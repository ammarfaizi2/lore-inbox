Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267321AbSKSVeg>; Tue, 19 Nov 2002 16:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbSKSVeg>; Tue, 19 Nov 2002 16:34:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:36605 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S267321AbSKSVef>; Tue, 19 Nov 2002 16:34:35 -0500
Date: Tue, 19 Nov 2002 21:42:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Steffen Persvold <sp@scali.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
In-Reply-To: <Pine.LNX.4.44.0211192209040.12652-100000@sp-laptop.isdn.scali.no>
Message-ID: <Pine.LNX.4.44.0211192131530.6987-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Steffen Persvold wrote:
> 
> I've two boxes with Dual Xeons 1.8 GHz and HT option enabled in BIOS. When 
> I boot 2.4.20-rc2 with default arguments the kernel detects 4 processors and 
> also reports 4 processors in /proc/cpuinfo wiht the "ht" feature.
> 
> However, if I boot with the "noht" option (wich I believed turned off HT 
> and therefore only two processors should be available), the kernel still 
> detects 4 processors, _but_ now the "ht" feature in /proc/cpuinfo is not 
> there. Is this the intention of the "noht" option ?

No, the intention of the "noht" option is as you believed, and it used to
work that way.  I looked at latest sourcec, didn't see anything obviously
wrong.  Sorry, but I don't have a suitable HT machine to check at present.

> If so, are there any 
> options available to turn off HT support in the kernel completely, so that 
> I don't have to go into the BIOS to turn it off ?
> 
> If you want to I can provide the dmesg output and .config.
> 
> I think this issue is not just related to 2.4.20-rc2, but earlier kernels 
> aswell.

Could others check and report if 2.4.20-rc2 "noht" works for them or not?

Thanks,
Hugh

