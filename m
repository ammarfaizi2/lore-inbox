Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268417AbTGNIwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 04:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268462AbTGNIwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 04:52:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:32971 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S268417AbTGNIwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 04:52:19 -0400
Date: Mon, 14 Jul 2003 11:07:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Nasrat <pauln@truemesh.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030714090701.GA31049@ucw.cz>
References: <20030711140219.GB16433@suse.de> <20030711150220.GG28359@raq465.uk2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711150220.GG28359@raq465.uk2net.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 04:02:21PM +0100, Paul Nasrat wrote:
> On Fri, Jul 11, 2003 at 03:02:19PM +0100, Dave Jones wrote:
>  
> > Known gotchas.
> > ~~~~~~~~~~~~~~
> > Certain known bugs are being reported over and over. Here are the
> > workarounds.
> > - Blank screen after decompressing kernel?
> >   Make sure your .config has
> >   CONFIG_INPUT=y, CONFIG_VT=y, CONFIG_VGA_CONSOLE=y and CONFIG_VT_CONSOLE=y
> >   A lot of people have discovered that taking their .config from 2.4 and
> >   running make oldconfig to pick up new options leads to problems, notably
> >   with CONFIG_VT not being set.
> 
> You might want to mention the synaptics touchpad driver/event for
> XFree86, as I'm sure that will be a FAQ amongst laptop users
> 
> http://w1.894.telia.com/~u89404340/touchpad/

Yes, please, this is very much needed.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
