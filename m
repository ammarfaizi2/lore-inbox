Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbTCZJO0>; Wed, 26 Mar 2003 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbTCZJOZ>; Wed, 26 Mar 2003 04:14:25 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:20387 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261514AbTCZJOY>;
	Wed, 26 Mar 2003 04:14:24 -0500
Date: Wed, 26 Mar 2003 10:25:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arne Koewing <ark@gmx.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Synaptics touchpad with Trackpoint needs ps/2 reset
Message-ID: <20030326102533.A17638@ucw.cz>
References: <87r88uv7hf.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me> <20030326095010.A17442@ucw.cz> <87r88uiis8.fsf@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87r88uiis8.fsf@gmx.net>; from ark@gmx.net on Wed, Mar 26, 2003 at 10:22:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 10:22:47AM +0100, Arne Koewing wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Tue, Mar 25, 2003 at 08:25:47AM +0100, Arne Koewing wrote:
> >> Hi!
> >> 
> >> I recently posted this to linux-kernel (with a different subject)
> >> I had included a wrong ptch there, i think this one is ok.
> >
> > Do we really need RESET_BAT? Doesn't any other command help?
> >
> I've used this because it is what tpconfig is using.
> I've tried all I could think of 
> (except of Synaptics-specials that I might not know)
> RESET_BAT is the only one that works...
> 
> I'll study the Synaptics TP Interfacing Guide again...

I mean - if we use RESET_BAT, I'd expect all config done before to be
lost ... maybe we want this, but won't this kill all the extra touchpad
functionality? We most likely won't be able to read absolute touchpad
values, etc. It might not be possible to use the touchpad with a
touchpoint together with touchpad extra functionality ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
