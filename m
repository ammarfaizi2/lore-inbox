Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290378AbSAPHHs>; Wed, 16 Jan 2002 02:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290375AbSAPHHj>; Wed, 16 Jan 2002 02:07:39 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:39653 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S290379AbSAPHHY>; Wed, 16 Jan 2002 02:07:24 -0500
Date: Wed, 16 Jan 2002 09:07:11 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Nicholas Lee <nj.lee@plumtree.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: Disk corruption - Abit KT7, 2.2.19+ide patches
Message-ID: <20020116070710.GT51774@niksula.cs.hut.fi>
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz> <20020115205116.GH51648@niksula.cs.hut.fi> <20020115211032.GC598@inktiger.kiwa.co.nz> <20020115214049.GI51648@niksula.cs.hut.fi> <20020115220211.GE598@inktiger.kiwa.co.nz> <000f01c19e18$469a3700$0501a8c0@psuedogod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c19e18$469a3700$0501a8c0@psuedogod>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 05:59:19PM -0500, you [Ed Sweetman] claimed:
> 
> sounds like you're using the shared irq slot, might want to verify that with
> lspci -vvv to see if anything else is using an irq at the time that's the
> same as the card in that slot.  Also some places will do various special
> things to one of the last pci slots, you should be able to find out by
> looking in the manual.  Some cards just dont play nicely with shared irqs.

Oh, I check some time ago. Sorry for baing vague, but as I said, we expect
to post more info in a couple of days. 

The card was in a slot that shares an IQR with something called "serial bus
controller" (and USB gadget, I gather.) It's _not_ in the slot that shares
the IRQ with (both) HPT370 controllers.

USB is disabled in BIOS and in kernel config. Ansolutely no USB devices
attached.

> describing.   I'm not really sure how this is a linux problem though since
> you mention it's occuring only in a certain physical slot.

No. I'm pretty positive this is a case of Via PCI being flaky.


-- v --

v@iki.fi
