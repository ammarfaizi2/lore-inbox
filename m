Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265678AbSJSU6n>; Sat, 19 Oct 2002 16:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265680AbSJSU6n>; Sat, 19 Oct 2002 16:58:43 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:34176 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265678AbSJSU6l>;
	Sat, 19 Oct 2002 16:58:41 -0400
Date: Sat, 19 Oct 2002 23:04:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, Jan Dittmer <jan@jandittmer.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Message-ID: <20021019230434.A800@ucw.cz>
References: <200210190241.49618.jan@jandittmer.de> <20021019091518.GG871@suse.de> <20021019222403.B3018@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021019222403.B3018@ucw.cz>; from vojtech@suse.cz on Sat, Oct 19, 2002 at 10:24:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 10:24:03PM +0200, Vojtech Pavlik wrote:

> > It's not an oops, and it's not causes by TCQ either. The above is simply
> > a reminder to fix the ide init sequence, because it's probe sequence
> > tries to use drive->disk before it has been set up. That is worked
> > around, but stack is dumped for good measure. So you can feel
> > comfortable using 2.5.44 regardless.
> > 
> > But I'm curious about TCQ on your system, since another VIA user
> > reported problems. Does it appear to work for you?
> 
> It definitely works on my VIA just fine.

Famous last words. I tried to play with the /proc using_tcq setting and
got a filesystem corruption immediately.

-- 
Vojtech Pavlik
SuSE Labs
