Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315235AbSD2XMz>; Mon, 29 Apr 2002 19:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315236AbSD2XMy>; Mon, 29 Apr 2002 19:12:54 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:47374 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315235AbSD2XMy>; Mon, 29 Apr 2002 19:12:54 -0400
Subject: Re: 2.5.11 + framebuffer compile patch -- OOPS in
	blk_get_readahead+a/60
From: Miles Lane <miles@megapathdsl.net>
To: James Simmons <jsimmons@transvirtual.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10204291522510.29647-100000@www.transvirtual.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 29 Apr 2002 16:10:46 -0700
Message-Id: <1020121847.1918.36.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-29 at 15:23, James Simmons wrote:
> 
> > >>EIP; c01ee59a <blk_get_readahead+a/60>   <=====
> > Trace; c023a87c <device_size_calculation+ac/230>
> > Trace; c023ab1f <do_md_run+11f/3d0>
> > Trace; c02286eb <fbcon_cursor+9b/200>
> 
> That is strange. Which framebuffer driver are you using?

Oh heck.  I thought I included the console options in my 
first message, but I see I didn't.  Sorry about that.

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y


