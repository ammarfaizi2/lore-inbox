Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUBIJTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 04:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUBIJTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 04:19:19 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:33410 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264444AbUBIJTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 04:19:18 -0500
Date: Mon, 9 Feb 2004 10:09:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Isaac Claymore <clay@exavio.com.cn>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040209090955.GA1222@ucw.cz>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402050454.44936.ctpm@rnl.ist.utl.pt> <20040205102023.GB497@exavio.com.cn> <20040209061532.GA486@exavio.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040209061532.GA486@exavio.com.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 02:15:32PM +0800, Isaac Claymore wrote:

> > >   I saw the same here yesterday, using a logitech wheel mouse:
> > > 
> > > Feb  4 18:19:46 vega kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 
> > > lost synchronization, throwing 2 bytes away.
> > > 
> > >   Before this happened the mouse in X just went nuts with random clicks in 
> > > many windows, but after that it's been ok up to now.
> > > 
> > I've been suffering this same problem ever since upgrade to 2.6 kernel.
> > 
> > FYI, here is an article giving some possible solutions to this, but I
> > failed to fix my mouse problem by any method it suggests:
> > 
> > http://kerneltrap.org/node/view/2199
> > 
> > 
> 
> Just FYI:
> 
> This annoying mouse problem hasn't shown up for 3 days, after I did a 
> 'hdparm -u1 /dev/hda'. But be sure to read the hdparm man page before 
> doing this on your box.

I think you're looking for 'hdparm -d1 /dev/hda', if your mainboard is
not very very old. That'll have a better effect.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
