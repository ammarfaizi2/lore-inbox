Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbRFZQxR>; Tue, 26 Jun 2001 12:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265036AbRFZQxH>; Tue, 26 Jun 2001 12:53:07 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:40964 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S265038AbRFZQw4>;
	Tue, 26 Jun 2001 12:52:56 -0400
Date: Tue, 26 Jun 2001 18:55:54 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Guest section DW <dwguest@win.tue.nl>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wrong disk index in /proc/stat
In-Reply-To: <20010626174942.A24389@win.tue.nl>
Message-ID: <Pine.LNX.4.30.0106261840270.13052-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [go to ftp://ftp.XX.kernel.org/pub/linux/kernel/people/aeb/ or so
> and get patches 01*, 02*, ... and apply them successively to 2.4.6pre5.
> complain to aeb@cwi.nl if anything is wrong]

I see, you're going for a much deeper patch. No objections whatsoever,
that's certainly a better solution, but I can't start testing it now (my
IA-64 machine has enough other problems to solve yet).

My patch was merely intended to correct the index for disks on the 1st
IDE controller, which is just plain wrong.

I (being new to kernel hacking) have yet to understand what needs
to happen for patches to enter the main branches.

Cheers,
Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113



