Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbTFMVzQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbTFMVzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:55:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59053 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265535AbTFMVzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:55:12 -0400
Date: Sat, 14 Jun 2003 00:08:57 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: Peter Berg Larsen <pebl@math.ku.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030614000857.B10851@ucw.cz>
References: <20030613223846.A9080@ucw.cz> <Pine.LNX.4.44.0306132140520.29353-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0306132140520.29353-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Fri, Jun 13, 2003 at 09:51:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 09:51:29PM +0100, James Simmons wrote:
> 
> > > Just as a idea for API. How about ABS_AREA or REL_AREA instead of 
> > > ABS_MISC. The idea is the pressure value returned should be about 
> > > the same if one presses hard with one finger or softly with a whole 
> > > hand.
> > 
> > Huh? Force = Pressure x Area ... I think you're mixing up force and
> > pressure here.
> 
> OOps. Your right. I'm thinking the hardware returns a force value. What I 
> meant is since we have the hardware returning the pressure and the area 
> this data can be used. Knowing the area over which a pressure is applied 
> is a good thing. What do you think?

Definitely. Still it doesn't cover the multi-tap/gesture stuff.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
