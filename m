Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbUBWFvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbUBWFvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:51:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13843 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261823AbUBWFvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:51:11 -0500
Date: Mon, 23 Feb 2004 06:44:35 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Michael <leahcim@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ALSA] emu10k1 driver oops loading large soundfont 2.6.3
Message-ID: <20040223054435.GA7785@alpha.home.local>
References: <40398E3C.7020900@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40398E3C.7020900@ntlworld.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 05:23:08AM +0000, Michael wrote:
> please CC: me on replies
> 
> In struct snd_emu10k1_memblk in include/sound/emu10k1.h first_page and 
> last_page are defined as short.

Thanks a lot !

I've had this problem for about a year, making it impossible to load a
full fluidr3 sound font at once. I've searched for the cause of the problem,
but didn't find anything and concluded that it should have been a hardware
limitation, which in fact was not !

Great catch !

Cheers,
Willy

