Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261583AbSKCDh2>; Sat, 2 Nov 2002 22:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSKCDh2>; Sat, 2 Nov 2002 22:37:28 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:43665 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S261583AbSKCDh1> convert rfc822-to-8bit; Sat, 2 Nov 2002 22:37:27 -0500
Date: Sat, 02 Nov 2002 21:43:23 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 2/2 2.5.45 cleanup & add original copy_ro/from_user
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3DC415DA.29D22E92@digeo.com>
References: <20021102060423.032A.AT541@columbia.edu> <3DC415DA.29D22E92@digeo.com>
Message-Id: <20021102214117.3797.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop015.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 21:43:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Nov 2002 10:13:46 -0800
Andrew Morton <akpm@digeo.com> mentioned:

> Well you could make it dependent on CONFIG_SLOW_KERNEL ;)

>From my patch, about the speed:
for PIII/4 CPU -> no change. using the same 2.5.45 copy.
for old i386 -> more optimal.
for Athlon -> 2.5.45 does not use unrolled copy for it either.

I am away for a while but I grew up in Japan and just wanted to save
some rooms for a embedded system like below.
http://linux.ascii24.com/linux/news/today/2000/05/22/imageview/images461056.jpg.html
The phisical size(not kernel) is about 5cm*5cm.
Is your copy function suitable in this case?



