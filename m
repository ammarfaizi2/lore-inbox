Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269092AbUJESNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269092AbUJESNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269113AbUJESNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:13:01 -0400
Received: from spirit.analogic.com ([208.224.221.4]:2067 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S269092AbUJESM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:12:56 -0400
From: "Johnson, Richard" <rjohnson@analogic.com>
Reply-To: "Johnson, Richard" <rjohnson@analogic.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 5 Oct 2004 14:17:01 -0400 (EDT)
Subject: Linux-2.6.5-1.358 and Fedora
Message-ID: <Pine.LNX.4.53.0410051413520.3024@quark.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In order to use Linux version 2.6.x, I installed the
stuff that came with the "Red Hat Fedora(tm) Linux 2"
book. I even bought a new hard disk so that it wouldn't
break anything I have on my other disks.

It installed, but I needed to set up a module development
environment so I attempted to compile the kernel with
the provided files.

First I copied a .config file from /usr/src/linux-2.6.5-1.358/configs
that came with the other software. Then I did:

make oldconfig
make bzImage
make modules
make modules_install

This seemed to go alright. Then I entered:

make install

This had some warning about module versions, but it seemed to work.

Then I re-booted. Naturally nothing worked. This stuff is getting more
like W$ every day.


The following hand-copied error messages exist and the root-file
system fails to be found because all the modules fail to install.


aic7xxx: version magic '2.6.5-1.358 SMP 686 REGPARM 4KSTACKS gcc-3.3`
             should be '2.6.5-1.358 SMP 686 REGPARM 4KSTACKS gcc-3.3`


All the modules that get installed by initrd have the same kind
of error message where "version magic" claims that it doesn't
compare with something that looks okay to the eye.

Also, the repair provisions don't have any capability of
copying back the contents of /lib/modules/  in any usable
way. I had to reinstall everything from scratch, just like
Windows. Nice work.



Richard B. Johnson
Project Engineer
Analogic Corporation
Penguin : Linux version 2.2.15 on an i586 machine (330.14 BogoMips).
