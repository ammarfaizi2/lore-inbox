Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757081AbWK3EAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081AbWK3EAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757890AbWK3EAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:00:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:31650 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1757081AbWK3EAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:00:52 -0500
X-Authenticated: #24879014
Message-ID: <456E4B50.1020007@gmx.net>
Date: Wed, 29 Nov 2006 19:09:04 -0800
From: Michael Kerrisk <mtk-manpages@gmx.net>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-2.43 is released
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I just released man-pages-2.43.

This release is now available for download at:

    ftp://ftp.kernel.org/pub/linux/docs/manpages
    or mirrors: ftp://ftp.XX.kernel.org/pub/linux/docs/manpages

and soon at:

    ftp://ftp.win.tue.nl/pub/linux-local/manpages

Changes in this release that may be of interest to readers
of this list include the following:

Changes to individual pages
---------------------------

rtc.4
    David Brownell

        Update the RTC man page to reflect the new RTC class framework:

        - Generalize ... it's not just for PC/AT style RTCs, and there
          may be more than one RTC per system.

        - Not all RTCs expose the same feature set as PC/AT ones; most
          of these ioctls will be rejected by some RTCs.

        - Be explicit about when {A,P}IE_{ON,OFF} calls are needed.

        - Describe the parameter to the get/set epoch request; correct
          the description of the get/set frequency parameter.

        - Document RTC_WKALM_{RD,SET}, which don't need AIE_{ON,OFF} and
          which support longer alarm periods.

        - Hey, not all system clock implementations count timer irqs any
          more now that the new RT-derived clock support is merging.

raw.7
udp.7
    Andi Kleen
        Describe the correct default for UDP/RAW path MTU discovery.

==

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7

Want to help with man page maintenance?  Grab the latest tarball at
http://www.kernel.org/pub/linux/docs/manpages/
read the HOWTOHELP file and grep the source files for 'FIXME'.

