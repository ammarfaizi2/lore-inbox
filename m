Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVBIUN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVBIUN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVBIULl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:11:41 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:58535 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261916AbVBIUKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:10:02 -0500
Date: Wed, 9 Feb 2005 21:10:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paulo Marques <pmarques@grupopie.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209201032.GA2159@ucw.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209191817.GA1534@ucw.cz> <20050209200351.GK10594@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209200351.GK10594@lug-owl.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 09:03:51PM +0100, Jan-Benedict Glaw wrote:

> > > It's even worse. Most keyboards don't separate the real keys from 
> > > magnetic stripe reader events, and just simulate key presses for MSR 
> > > data. They expect the software to be in a state where it is waiting for 
> > > that data, and will process it accordingly.
> > 
> > In that case I'm not sure if the kernel should care at all what the data
> > is.
> 
> The problematic part is that this needs to be done at a quite low level,
> since POS keyboards may send quite a lot more than make/break codes in
> "proper" order...

I'll need some specific examples of protocols the keyboard use to judge
how to tackle that.

> > > What we've done in our application is to use the timings and sequence of 
> > > key presses to distinguish between normal key presses and MSR data :P
> > 
> > Yes, embedded and single purpose systems are often full of hacks like
> > this.
> 
> ...and especially this problem can be better solved by reprogramming the
> MCR readers :-)


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
