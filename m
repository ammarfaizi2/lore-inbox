Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBNHPH>; Wed, 14 Feb 2001 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131502AbRBNHOr>; Wed, 14 Feb 2001 02:14:47 -0500
Received: from rhinocomputing.com ([161.58.241.147]:48145 "EHLO
	rhinocomputing.com") by vger.kernel.org with ESMTP
	id <S129027AbRBNHOl>; Wed, 14 Feb 2001 02:14:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14986.12379.73487.400038@rhino.thrillseeker.net>
Date: Wed, 14 Feb 2001 02:14:35 -0500 (EST)
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: swap errors
X-Mailer: VM 6.75 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.4.1-ac11 I'm getting errors like:

Feb 14 02:10:09 rhino kernel: Unused swap offset entry in swap_count 004dda00
Feb 14 02:10:09 rhino kernel: VM: Bad swap entry 004dda00

over and over.  The system has 512M real and 1G swap allocated.  This
is occuring at:

Mem:    512492K total,   397780K used,   114712K free,     1192K buffers
Swap:   982792K total,   284380K used,   698412K free,   298556K cached

while running imagemagick on a bunch of tifs to convert them to jpgs.

It's the first time I've seen this error.  Is it more likely that the
swap file has gone south or is it indicative of something else?

Billy
