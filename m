Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133029AbRDZW0Q>; Thu, 26 Apr 2001 18:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135201AbRDZW0H>; Thu, 26 Apr 2001 18:26:07 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:26241 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S133029AbRDZWZ4>; Thu, 26 Apr 2001 18:25:56 -0400
Date: Fri, 27 Apr 2001 00:25:54 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
Message-ID: <20010427002554.D679@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AE879AE.387D3B78@antefacto.com> <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se> <9ca1k1$4ap$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9ca1k1$4ap$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Apr 26, 2001 at 01:49:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 01:49:05PM -0700, H. Peter Anvin wrote:
> > > 5. Can you set size limits on ramfs/tmpfs/memfs?

Yes, there is a patch for this.

> > i don't think you can set a limit in the current ramfs implementation but
> > it would not be particularly difficult to make it work I think
> It's a little more painful than you'd think for the simple reason that
> ramfs currently contains no space accounting whatsoever, which
> probably is a bad thing.  It definitely gave me some serious pause
> when I was working on SuperRescue 1.3, since I had no way of
> reasonably judging how big my ramfs actually was.  The only way I
> could get a reasonable idea was rebooting with various mem=
> parameters.

The patched variant gives to all of it. Even several kinds of
limits (inodes, dentries, ram pages).

I use this patch in production. 

The ac-Kernels all have this patch included, which are sometimes
more stable anyway these day. ;-)

HTH

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
