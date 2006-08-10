Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWHJFN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWHJFN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWHJFN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:13:56 -0400
Received: from mail.jambit.com ([62.245.207.83]:56457 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S1161032AbWHJFN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:13:56 -0400
Message-ID: <44DABFFD.7060004@gmx.net>
Date: Thu, 10 Aug 2006 07:11:25 +0200
From: Michael Kerrisk <mtk-manpages@gmx.net>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-2-38 and man-pages-2.39 are released
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.38 and man-pages-2.39, which can be found
at the location in the .sig.

There was one new page in these releases, describing various Unix standards:

standards.7
    mtk
        Based on material taken from intro.2, but expanded to
        include discussion of many additional standards.

There was a significant reworking of the CONFORMING TO sections
in most manual pages.
    mtk

    * generally try to rationalise the names used for standards.
      The preferred names are now documented as the head words
      of the list in standards(7).  For the future: there is
      probably no need to talk about anything more than
      C89, C99, POSIX.1-2001 (or later), xBSD, and SVr4.
      (In particular, I've eliminated most references to XPG
      and SVID, replacing them with references to SUS or SVr4.)

    * eliminate discussion of errors that can occur on other
      systems.  This information exists only patchily in the
      manual pages, is probably of limited use, is hard to maintain,
      and was in some cases simply wrong (and probably always was).

    * Tried to ensure that those interfaces specified in C99 or
      POSIX.1-2001 are marked as such in their manual pages.

=======================================================

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

Want to help with man page maintenance?  Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/,
read the HOWTOHELP file and grep the source files for 'FIXME'.
