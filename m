Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSGMND3>; Sat, 13 Jul 2002 09:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSGMND3>; Sat, 13 Jul 2002 09:03:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:15614 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316851AbSGMND2>; Sat, 13 Jul 2002 09:03:28 -0400
Subject: Re: Q: boot time memory region recognition and clearing.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2FFC22.49A057CD@yk.rim.or.jp>
References: <3D2FFC22.49A057CD@yk.rim.or.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 15:15:17 +0100
Message-Id: <1026569717.9958.77.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 11:08, Ishikawa wrote:
> I have found that the particular motherboard (and memory sticks)
> that I use at home tends to generate bogus memory problem 
> warning messages when I use ecc module.
> Motherboard is Gigabyte 7XIE4 that uses AMD751.
> (Yes, AMD has now provides AMD76x series chipset for
> newer CPUs.)
> 
> I say "bogus" because I have tested the hardware
> many times using memtest86 and found that it doesn't
> detect any memory errors even 

memtest86 isnt (except on the very very latest versions) aware of ECC.
It sees the memory after the ECC rescues minor errors so if the RAM has
errors but ECC just about saves you it will show up clean

