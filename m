Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWE3D2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWE3D2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 23:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWE3D2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 23:28:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:14226 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751187AbWE3D2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 23:28:25 -0400
X-Authenticated: #24879014
Message-ID: <447BBB6B.3070003@gmx.net>
Date: Tue, 30 May 2006 15:26:35 +1200
From: Michael Kerrisk <mtk-manpages@gmx.net>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-2.33 is released
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.33, which can be found at the
location in the .sig.

Changes in this release that may be of interest to readers
of this list include the following:

New page
--------

mq_getsetattr.2
   mtk
       New page briefly describing mq_getsetattr(2), the system
       call that underlies mq_setattr(3) and mq_getattr(3).


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

Want to help with man page maintenance?  Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/,
read the HOWTOHELP file and grep the source files for 'FIXME'.
