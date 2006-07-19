Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWG0C5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWG0C5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 22:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWG0C5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 22:57:48 -0400
Received: from mail.jambit.com ([62.245.207.83]:44008 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S932065AbWG0C5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 22:57:47 -0400
Message-ID: <44BE5A04.6080106@gmx.net>
Date: Wed, 19 Jul 2006 18:12:52 +0200
From: Michael Kerrisk <mtk-manpages@gmx.net>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-2.35 is released
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.35, which can be found at the
location in the .sig.

Changes in this release that may be of interest to readers
of this list include the following:

New pages
---------

sync_file_range.2
   Andrew Morton / mtk
      New page for sync_file_range(2), new in kernel 2.6.17.

Changes to individual pages
---------------------------

epoll_ctl.2
    mtk / Davide Libenzi
        Added EPOLLRDHUP description.

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
Grab the latest tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/,
read the HOWTOHELP file and grep the source files for 'FIXME'.


