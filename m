Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319378AbSH2VEf>; Thu, 29 Aug 2002 17:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319380AbSH2VEe>; Thu, 29 Aug 2002 17:04:34 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:15502 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319378AbSH2VEd>;
	Thu, 29 Aug 2002 17:04:33 -0400
Date: Thu, 29 Aug 2002 23:08:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard freezes on SIS630 based Clevo notebooks
Message-ID: <20020829230841.B4175@ucw.cz>
References: <20020829190533.GA11223@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020829190533.GA11223@informatik.uni-bremen.de>; from jmm@informatik.uni-bremen.de on Thu, Aug 29, 2002 at 09:05:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 09:05:33PM +0200, Moritz Muehlenhoff wrote:

> Hi,
> I own a SIS630 based notebook from Baycom (model name "Worldbook II"), which
> indeed is a rebrand from a Clevo/Kapok model (normal model name 2700C).
> 
> I'm experiencing occasional, unreproducable keyboard lockups. No keyboard
> input at all is accepted while the machine itself continues to work
> properly (processes continue to write to stdout and I can login and 
> continue to work through SSH). The freezes occur approx. at least once
> a week and sometimes three times a day, so there's no real pattern behind
> it.
> 
> A friend of mine owns the same model and the same problems occur; I also
> found a website stating the same problems on it; so it's of general nature
> and not specific to my hardware. I didn't find any information about these
> freezes running Windows, so I guess it's Linux-kernel specific and not a sole
> hardware issue.
> 
> The system freezed on all kinds of kernel, either 2.4 and 2.5, either
> vanilla and heavily patched.
> 
> So, the big question: Which data would I need to collect on the next freeze
> that would allow an experienced kernel hacker to track down the problem?
> 
> This nasty bug is the only thing in the way to a perfect Linux notebook,
> everything else works just perfect.

If it freezes with 2.5.32 (or better the latest BK tree), then #define
I8042_DEBUG_DATA in drivers/input/serio/i8042.h and send me the log of
the last i8042 data before the freeze. 

-- 
Vojtech Pavlik
SuSE Labs
