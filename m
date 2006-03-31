Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWCaXo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWCaXo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWCaXo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:44:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:28336 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751448AbWCaXo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:44:27 -0500
Date: Sat, 1 Apr 2006 01:44:26 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <5159.1143403544@www006.gmx.net>
Subject: man-pages-2.28 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <6915.1143848666@www076.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.28, which can be found at:

    ftp://ftp.win.tue.nl/pub/linux-local/manpages

or:

    ftp://ftp.kernel.org/pub/linux/docs/manpages
    or mirrors: ftp://ftp.XX.kernel.org/pub/linux/docs/manpages

This release includes the following new pages:

sem_post.3
sem_getvalue.3
sem_close.3
sem_open.3
sem_destroy.3
sem_wait.3
sem_unlink.3
sem_init.3
sem_overview.7
    mtk
        New pages describing the POSIX semaphores API.

        These pages supercede and provide a superset of the information 
        in the glibc (3thr) "semaphores(3)" manual page.

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
