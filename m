Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314753AbSD3Sve>; Tue, 30 Apr 2002 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314767AbSD3Sve>; Tue, 30 Apr 2002 14:51:34 -0400
Received: from www.transvirtual.com ([206.14.214.140]:4103 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S314753AbSD3Svd>; Tue, 30 Apr 2002 14:51:33 -0400
Date: Tue, 30 Apr 2002 11:51:24 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Miles Lane <miles@megapathdsl.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.11 + framebuffer compile patch -- OOPS in blk_get_readahead+a/60
In-Reply-To: <1020121847.1918.36.camel@turbulence.megapathdsl.net>
Message-ID: <Pine.LNX.4.10.10204301150510.24456-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you try it again with the lastest patch from my URL. I just tested it
and it worked. 

http://www.transvirtual.com/~jsimmons/fbdev_fixs.diff

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

On 29 Apr 2002, Miles Lane wrote:

> On Mon, 2002-04-29 at 15:23, James Simmons wrote:
> > 
> > > >>EIP; c01ee59a <blk_get_readahead+a/60>   <=====
> > > Trace; c023a87c <device_size_calculation+ac/230>
> > > Trace; c023ab1f <do_md_run+11f/3d0>
> > > Trace; c02286eb <fbcon_cursor+9b/200>
> > 
> > That is strange. Which framebuffer driver are you using?
> 
> Oh heck.  I thought I included the console options in my 
> first message, but I see I didn't.  Sorry about that.
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> 
> #
> # Frame-buffer support
> #
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_FB_RIVA=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FBCON_CFB8=y
> CONFIG_FBCON_CFB16=y
> CONFIG_FBCON_CFB32=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> 
> 

