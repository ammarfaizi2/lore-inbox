Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278829AbRLALWi>; Sat, 1 Dec 2001 06:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280203AbRLALW2>; Sat, 1 Dec 2001 06:22:28 -0500
Received: from hera.cwi.nl ([192.16.191.8]:62454 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S278829AbRLALWQ>;
	Sat, 1 Dec 2001 06:22:16 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 1 Dec 2001 11:22:01 GMT
Message-Id: <UTC200112011122.LAA118894.aeb@cwi.nl>
To: aia21@cus.cam.ac.uk, torvalds@transmeta.com
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Anton Altaparmakov <aia21@cus.cam.ac.uk>

    Linus,

    Please consider below patch which adds the starting sector and number of
    sectors to /proc/partitions.

    It works fine here and I find having this information output can be very
    useful (especially when the values in the kernel don't match the values
    output by fdisk for example).

Of course this breaks all programs that use /proc/partitions,
like fdisk and mount. Every system that uses mount-by-label will be broken.

Andries
