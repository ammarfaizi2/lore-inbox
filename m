Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUBHRSv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 12:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUBHRSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 12:18:50 -0500
Received: from dsl-213-023-007-056.arcor-ip.net ([213.23.7.56]:13732 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S263937AbUBHRSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 12:18:49 -0500
Date: Sun, 8 Feb 2004 18:17:07 +0100
From: Georg C F Greve <greve@gnuhh.org>
Message-Id: <200402081717.i18HH7Ub003181@brain.gnuhh.org>
To: linux-kernel@vger.kernel.org
CC: Ari Pollak <ajp@aripollak.com>
Subject: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook
In-Reply-To: <c05m86$20g$1qsea.gmane.org>
References: <c05m86$20g$1qsea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > I should clarify that this does not happen on *all* Centrino
 > notebooks (and not the ones I've tried), only some.

Do you still remember which notebooks you did _not_ encounter these
problems with? More particularly which chipsets they had? I've seen so
many reports for this problem that it would be interesting to know
where it does _not_ exist.

The number of notebooks with that problem seems considerable -- people
reported these problems on different Centrino notebooks from different
vendors, particularly

 ASUS M and S series
 ACER TravelMate
 IBM Thinkpad R50P

that all seemed to have precisely one thing in common: the Intel 855GM
centrino chipset.

Similar problems have also been reported from Fujitsu-Siemens e6624
notebook, which has an intel i830 chipset. As the kernel 2.6 currently
seems to use the i830 AGP driver for the Intel 855GM chipset, those
two might (or might not) be related.

That we have not seen more reports is probably because people are
still mostly using 2.4.x on their notebooks, which was better for
suspend/resume (I'm using a patched 2.4.24 as I'm writing this).

Regards,
Georg
