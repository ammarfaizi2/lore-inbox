Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTEPQMh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTEPQMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:12:37 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6321 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264481AbTEPQMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:12:36 -0400
Date: Fri, 16 May 2003 18:25:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David van Hoose <davidvh@cox.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Support for SiS 961/961B/962/963/630S/630ET/633/733 IDE
Message-ID: <20030516182521.A21496@ucw.cz>
References: <20030516143021.A17346@ucw.cz> <3EC50CD9.6020508@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EC50CD9.6020508@cox.net>; from davidvh@cox.net on Fri, May 16, 2003 at 12:07:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 12:07:53PM -0400, David van Hoose wrote:
 
> > The goal of this patch is to add support for the new generation of
> > MuTIOL southbridges by SiS, namely the 961/961B, 962 and 963. These
> > integrate the IDE controller, unlike all other SiS chipsets where the
> > controller is bound to the northbridge.
> > 
> > I had to do quite some research on what SiS IDE controllers exist that
> > don't use the 96* southbridges, and thus found out that the 633 and 733
> > controllers were missing. So those were added too.
> > 
> > This patch hovewer integrates a patch from Lionel which adds 630S/ET
> > UDMA100 support.
> > 
> > And while doing the changes I did also some cleanups, mainly removing a
> > bunch of debug code that doesn't seem very useful when lspci does the
> > same job. And removing the config_drive_xfer_rate in favor of functions
> > from ide-timing.h.
> > 
> > Tested on SiS963, works great.
> > 
> > Patches for current 2.4 and 2.5 attached.
> 
> I never thought about it, but my SiS963 is not recognized in lspci. The 
> below is a link which has a diagram of the SiS648/SiS963 combo that is 
> on my motherboard. Would it enhance performance any or would this 
> correction just be cosmetic?

There will most likely be no change for you.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
