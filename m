Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSGHLGC>; Mon, 8 Jul 2002 07:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSGHLGB>; Mon, 8 Jul 2002 07:06:01 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:11688 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316842AbSGHLGA>;
	Mon, 8 Jul 2002 07:06:00 -0400
Date: Mon, 8 Jul 2002 13:08:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: James Simmons <jsimmons@transvirtual.com>, torvalds@transmeta.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       vojtech@twilight.ucw.cz
Subject: Re: [patch] Typo fixes in input code
Message-ID: <20020708130816.C22144@ucw.cz>
References: <Pine.LNX.4.44.0207061047370.26054-100000@www.transvirtual.com> <200207071222.48783.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207071222.48783.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Sun, Jul 07, 2002 at 12:22:48PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 12:22:48PM +1000, Brad Hards wrote:
> On Sun, 7 Jul 2002 03:48, James Simmons wrote:
> > You patch is right except for drivers/input/gameport/Config.help. That was
> > right before your patch.
> OK. I assumed that Config.in was the authoritative source, and Config.help 
> should match. Looks like (based on the Makefile) that I probably should have 
> changed it to be CONFIG_GAMEPORT_EMU10K1 in the Config.in. In fact, that 
> driver won't ever be built with vanilla 2.5.25, with or without the previous 
> patch
> 
> BK already has the previous change applied, so this in an incremental diff:
> 
> <bk text>
> EMU10K1 build fix
> 
> Revert the CONFIG_INPUT_EMU10K1 change to drivers/input/gameport/Config.help, 
> and change drivers/input/gameport/Config.in to use CONFIG_GAMEPORT_EMU10K1
> </bk text> 

Thanks, applied.


-- 
Vojtech Pavlik
SuSE Labs
