Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264951AbRFZOFC>; Tue, 26 Jun 2001 10:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264952AbRFZOEw>; Tue, 26 Jun 2001 10:04:52 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:11283 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S264951AbRFZOEf>;
	Tue, 26 Jun 2001 10:04:35 -0400
Date: Tue, 26 Jun 2001 16:07:33 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Guest section DW <dwguest@win.tue.nl>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wrong disk index in /proc/stat
In-Reply-To: <20010626045614.A24248@win.tue.nl>
Message-ID: <Pine.LNX.4.30.0106261605200.13052-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On the other hand, in my tree:
>
> static inline unsigned int disk_index (kdev_t dev)
> {
>         struct gendisk *g = get_gendisk(dev);
>         return g ? (MINOR(dev) >> g->minor_shift) : 0;
> }

Well,

a) this is not in the official kernel,
b) the original genhd.h says that's too slow (is it really slower?)

Regards,
Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113



