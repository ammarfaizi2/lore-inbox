Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290906AbSASCl0>; Fri, 18 Jan 2002 21:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290907AbSASClQ>; Fri, 18 Jan 2002 21:41:16 -0500
Received: from ip210-55-103-15.dyndns.win.co.nz ([210.55.103.15]:10967 "HELO
	volcano.kiwa.co.nz") by vger.kernel.org with SMTP
	id <S290906AbSASClO>; Fri, 18 Jan 2002 21:41:14 -0500
Date: Sat, 19 Jan 2002 15:40:59 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk corruption - Abit KT7, 2.2.19+ide patches
Message-ID: <20020119024059.GD1568@inktiger.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz> <20020115205116.GH51648@niksula.cs.hut.fi> <20020115211032.GC598@inktiger.kiwa.co.nz> <20020115214049.GI51648@niksula.cs.hut.fi> <20020115220211.GE598@inktiger.kiwa.co.nz> <000f01c19e18$469a3700$0501a8c0@psuedogod> <20020116070710.GT51774@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116070710.GT51774@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 09:07:11AM +0200, Ville Herva wrote:

> Oh, I check some time ago. Sorry for baing vague, but as I said, we expect
> to post more info in a couple of days. 
> 
> The card was in a slot that shares an IQR with something called "serial bus
> controller" (and USB gadget, I gather.) It's _not_ in the slot that shares
> the IRQ with (both) HPT370 controllers.
> 
> USB is disabled in BIOS and in kernel config. Ansolutely no USB devices
> attached.
> 
> No. I'm pretty positive this is a case of Via PCI being flaky.

I opened the box, and yes the NIC was in PCI slot 3. I moved it to slot
1 and I'll patch up the bad blocks on that drive and see if it happens
again. 

Of course it took several months this time, and it's likely I'll be
upgrading that machine to 2.4. So the new drivers in 2.4 might handle
the buggy chipset.

-- 
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui caught.
gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C            icq. 1612865 

                         Quixotic Eccentricity
