Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271802AbRHRIxc>; Sat, 18 Aug 2001 04:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271800AbRHRIxW>; Sat, 18 Aug 2001 04:53:22 -0400
Received: from hr1-cf9a48a7.dsl.impulse.net ([207.154.72.167]:39185 "HELO
	madrabbit.org") by vger.kernel.org with SMTP id <S271797AbRHRIxK>;
	Sat, 18 Aug 2001 04:53:10 -0400
Subject: Re: [PATCH 2.4.8-ac6] (Yet) Another Sony Vaio laptop with a broken
	APM...
From: Ray Lee <ray-lk@madrabbit.org>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: stelian.pop@fr.alcove.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010817115100.E17372@turbolinux.com>
In-Reply-To: <998066618.31380.53.camel@orca> 
	<20010817115100.E17372@turbolinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 18 Aug 2001 01:53:23 -0700
Message-Id: <998124804.440.19.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001 11:51:00 -0600, Andreas Dilger wrote:
> Yes, I think the same is true with my PXG-XG9 (minutes being wrong),
> but I haven't actually tested if the patch works.  I always assumed
> it was because I have two batteries installed.

If the patch doesn't work for yours, then all you have to do is to open
up arch/i386/kernel/dmi_scan.c, and uncomment a #define as my previous
email to the list. Upon boot up, you should see the BIOS version and
date, and if it's not in the list then we can add it in easily.

--
Ray Lee  /  Every truth has a context.

