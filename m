Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWFTN51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWFTN51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWFTN51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:57:27 -0400
Received: from mail.gmx.de ([213.165.64.21]:36311 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750976AbWFTN50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:57:26 -0400
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 20 Jun 2006 15:57:25 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
Message-ID: <20060620135725.161550@gmx.net>
MIME-Version: 1.0
Subject: man-pages-2.34 is released
To: linux-kernel@vger.kernel.org
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.33, which can be found at the
location in the .sig.  

Changes in this release that may be of interest to readers
of this list include the following:

New pages
---------

ioprio_set.2
    Eduardo Madeira Fleury, with edits by mtk, and review by Jens Axboe
       New page for ioprio_get(2) and ioprio_set(2), new in 2.6.13.

Changes to individual pages
---------------------------

ftw.3
    Justin Pryzby / mtk
        A fairly major revision...
        Document FTW_ACTIONRETVAL; include .SH "RETURN VALUE";
        Reorganized and rewrote much of the page
        Added an example program.

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
