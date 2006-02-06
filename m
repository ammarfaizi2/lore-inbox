Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWBFT7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWBFT7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWBFT7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:59:48 -0500
Received: from mail.gmx.de ([213.165.64.21]:11150 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932344AbWBFT7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:59:47 -0500
Date: Mon, 6 Feb 2006 20:59:46 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net
MIME-Version: 1.0
Subject: man-pages-2.22 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <16806.1139255986@www031.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.22, which contains 
sections 2, 3, 4, 5, and 7 of the manual pages.  These 
sections describe the following:

2: (Linux) system calls
3: (libc) library functions
4: Devices
5: File formats and protocols
7: Overview pages, conventions, etc.

As far as this list is concerned the most relevant parts are: 
all of sections 2 and 4, which describe kernel-userland interfaces; 
in section 5, the proc(5) manual page, which attempts (it's always 
catching up) to be a comprehensive description of /proc; and 
various pages in section 7, some of which are overview pages of 
kernel features (e.g., networking protocols).

This is a request to kernel developers: if you make a change 
to a kernel-userland interface, or observe a discrepancy 
between the manual pages and reality, would you please send 
me (at mtk-manpages@gmx.net ) one of the following 
(in decreasing order of preference):

1. An in-line "diff -u" patch with text changes for the 
   corresponding manual page.  (The most up-to-date version 
   of the manual pages can always be found at
   ftp://ftp.win.tue.nl/pub/linux-local/manpages or
   ftp://ftp.kernel.org/pub/linux/docs/manpages .)

2. An email describing the changes, which I can then 
   integrate into the appropriate manual page.

3. A message alerting me that some part of the manual pages 
   does not correspond to reality.  Eventually, I will try to 
   remedy the situation.

Obviously, as we get further down this list, more of my time 
is required, and things may go slower, especially when the
changes concern some part of the kernel that I am ignorant 
about and I can't find someone to assist.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
