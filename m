Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287464AbSAPUlU>; Wed, 16 Jan 2002 15:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287471AbSAPUlJ>; Wed, 16 Jan 2002 15:41:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19212 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S287464AbSAPUlC>; Wed, 16 Jan 2002 15:41:02 -0500
Date: Wed, 16 Jan 2002 15:40:17 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <E16QV35-0000mZ-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020116153757.29791B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Daniel Phillips wrote:

> In a perfect world we would settle of one of big or little-endian and 
> byte-swap as appropriate, as we do with, e.g., Ext2 filesystems.  However it 
> seems that cpio in its current form has no concept of byte-swapping.  Cpio(1) 
> can neither generate nor decode a cpio file in the 'foreign' byte sex.  So if 
> we are determined to use cpio as it stands, then we are stuck with the goofy 
> ASCII encoding, does that sum up the situation?
> 
> Too bad about that, otherwise cpio seems quite reasonable.

I have to go back and look, isn't -Hcrc endian-neutral?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

