Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422807AbWJLHxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422807AbWJLHxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWJLHxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:53:14 -0400
Received: from mail.jambit.com ([62.245.207.83]:213 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S1422807AbWJLHxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:53:12 -0400
Message-ID: <452DF54C.8000202@gmx.net>
Date: Thu, 12 Oct 2006 09:57:00 +0200
From: Michael Kerrisk <mtk-manpages@gmx.net>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-2.41 is released
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.41.

This release is now available for download at:

    ftp://ftp.kernel.org/pub/linux/docs/manpages
    or mirrors: ftp://ftp.XX.kernel.org/pub/linux/docs/manpages

and soon at:

    ftp://ftp.win.tue.nl/pub/linux-local/manpages

Changes in this release that may be of interest to readers
of this list include the following:

New pages
---------

splice.2
tee.2
vmsplice.2
    Jens Axboe / Michael Kerrisk
        See also:
            http://lwn.net/Articles/118760/
            http://lwn.net/Articles/178199/
            http://lwn.net/Articles/179492/
            http://kerneltrap.org/node/6505
            http://lwn.net/Articles/179434/

Changes to individual pages
---------------------------

madvise.2
    mtk
        Document MADV_REMOVE, new in 2.6.16.
        Document MADV_DONTFORK / MADV_DOFORK, new in 2.6.16.

prctl.2
    Marcel Holtmann / mtk
        Since kernel 2.6.18, setting 2 for PR_SET_DUMPABLE is no longer
        possible.
    Guillem Jover
        Updated Linux versions where the options where introduced.
        Added PR_SET_TIMING, PR_GET_TIMING, PR_SET_NAME, PR_GET_NAME,
        PR_SET_UNALIGN, PR_GET_UNALIGN, PR_SET_FPEMU, PR_GET_FPEMU,
        PR_SET_FPEXC, PR_GET_FPEXC.
    Michael Kerrisk
        Document PR_GET_ENDIAN and PR_SET_ENDIAN.

posix_fadvise.2
    Andrew Morton
        Since 2.6.18, POSIX_FADV_NOREUSE is a no-op.

termios.3
    mtk
        Documented IUTF8 (which was new in kernel 2.6.4).

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7

Want to help with man page maintenance?  Grab the latest tarball at
http://www.kernel.org/pub/linux/docs/manpages/
read the HOWTOHELP file and grep the source files for 'FIXME'.
