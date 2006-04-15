Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWDOG7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWDOG7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 02:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWDOG7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 02:59:52 -0400
Received: from mx2.mail.ru ([194.67.23.122]:7975 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751571AbWDOG7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 02:59:52 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Which device did I boot from?
Date: Sat, 15 Apr 2006 10:59:37 +0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604151059.47733.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > Is there a way to determine which device I have booted from?  For
> > example, say I booted from a USB device, can I tell which one?  I did
> > not find anything in /proc FS other than the cmdline options.
>
> If you choose the (experimental) CONFIG_EDD option in your kernel then,
> with cooperation of your BIOS, you'll have a /sys/firmware/edd with at
> least some info about the BIOS boot device. For me:

I am sorry but it does not tell about boot device. It contains all hard disks 
enumerated via EDD interface. I do not see any information 
under /sys/firmware/edd that would have allowed to guess boot device.

- -andrey

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEQJnjR6LMutpd94wRAqIDAJ9fSZYjCXsecWXbuuC+rehMU/FL7ACfSmug
+OKNYJORExMX7oMrdjgIc+4=
=SDfj
-----END PGP SIGNATURE-----
