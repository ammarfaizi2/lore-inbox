Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUGIHQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUGIHQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 03:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUGIHQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 03:16:36 -0400
Received: from dsl-217-155-197-248.zen.co.uk ([217.155.197.248]:65032 "EHLO
	dsl-217-155-197-248.zen.co.uk") by vger.kernel.org with ESMTP
	id S264502AbUGIHQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 03:16:29 -0400
Date: Fri,  9 Jul 2004 08:16:27 +0100
Message-Id: <41-Fri09Jul2004081627+0100-jpff@codemist.co.uk>
X-Mailer: emacs 21.3.1 (via feedmail 8 I)
From: jpff@codemist.co.uk
To: linux-kernel@vger.kernel.org
Subject: A network problem?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a repeatable problems with kernels 2.4.25 and 2.4.26 which
is not present in 2.4.18

With the newer kernel transferring data via cp from a remote nfs
mounted file system takes very long times, with frequent nfs timeouts.
By long I mean more that 20 minutes to transfer 80Mb.  With 2.4.18 this
happens as fast as transfers to the remote machine (which is flawless
in 2.4.26 as well).  This is over a PCMCIA 100mbit ether card 
Jul  6 15:31:09 xenakis cardmgr[809]: socket 0: NE2000 Compatible Fast Ethernet
loaded as a module (at present I am using on a different network with wireless)

==John ffitch

Linux xenakis 2.4.26 #2 Sat Jul 3 16:00:32 BST 2004 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
quota-tools            3.01.
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         binfmt_misc ide-cs orinoco_cs orinoco hermes nls_iso8859-1 nls_cp437 usb-uhci usbcore
