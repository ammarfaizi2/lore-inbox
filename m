Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVCVHog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVCVHog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVCVHog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:44:36 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:29106 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262274AbVCVHnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:43:49 -0500
Date: Tue, 22 Mar 2005 08:44:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: mjt@tls.msk.ru, linux-kernel@vger.kernel.org
Subject: Re: mouse&keyboard with 2.6.10+
Message-ID: <20050322074435.GC3360@ucw.cz>
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru> <20050314142847.GA4001@ucw.cz> <4235B367.3000506@tls.msk.ru> <20050314162537.GA2716@ucw.cz> <4235BDFD.1070505@tls.msk.ru> <20050314164342.GA1735@ucw.cz> <20050321172411.247e32b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321172411.247e32b6.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 05:24:11PM -0800, Andrew Morton wrote:

> > Any chance the order of module loading changed between the two versions?
> > I see you have 'psmouse' as a module. If i8042 (and psmouse) are loaded
> > after uhci-hcd (or ohci-hcd), the problem will disappear, too.
> > 
> > > So is this a bios/mobo problem,
> > 
> > Yes.
> > 
> > > or can it be solved in kernel somehow?
> > 
> > We could have usb-handoff by default.
> 
> Did we decide to do that?  If so, will it be in 2.6.12?

Not yet. There was opposition from Alan Cox, who said that it crashes
some machines hard. On the other hand, that is a BIOS interaction bug
that most likely can be fixed and is very rare. I'd prefer a
'usb-no-handoff' switch for these machines.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
