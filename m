Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWEPWKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWEPWKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWEPWKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:10:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:52140 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932202AbWEPWKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:10:17 -0400
Date: Wed, 17 May 2006 00:10:16 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <29907.1146481443@www049.gmx.net>
Subject: man-pages-2.32 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <21942.1147817416@www019.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.32, which can be found at the 
location in the .sig.  

Changes in this release that may be of interest to readers
of this list include the following:

New pages
---------

faccessat.2
    mtk
        New page for faccessat(2), new in 2.6.16.

fchmodat.2
    mtk
        New page for fchmodat(2), new in 2.6.16.

fchownat.2
    mtk
        New page for fchownat(2), new in 2.6.16.

futimesat.2
    mtk
        New page for futimesat(2), new in 2.6.16.

Changes to individual pages
---------------------------

capabilities.7
    mtk
        Reworded to reflect that capabilities are per-thread.
        Add ioprio_set() to list of operations permitted by
        CAP_SYS_NICE.
        Add ioprio_set() IOPRIO_CLASS_RT and IOPRIO_CLASS_IDLE
        scheduling classes to list of operations permitted by
        CAP_SYS_ADMIN.
        Note effects of CAP_SYS_NICE for migrate_pages().


==========

The man-pages set contains sections 2, 3, 4, 5, and 7 of
the manual pages.  These sections describe the following:

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

If you make a change to a kernel-userland interface, or observe 
a discrepancy between the manual pages and reality, would you 
please send me (at mtk-manpages@gmx.net ) one of the following
(in decreasing order of preference):

1. An in-line "diff -u" patch with text changes for the
   corresponding manual page.  (The most up-to-date version
   of the manual pages can always be found at
   ftp://ftp.win.tue.nl/pub/linux-local/manpages or
   ftp://ftp.kernel.org/pub/linux/docs/manpages .)

2. Some raw text describing the changes, which I can then
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
