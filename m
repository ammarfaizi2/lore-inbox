Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUIPBBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUIPBBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUIPA7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 20:59:10 -0400
Received: from lakermmtao01.cox.net ([68.230.240.38]:58828 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S267377AbUIPAyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 20:54:16 -0400
From: tuxrocks@cox.net
To: linux-kernel@vger.kernel.org
Subject: Re: open source realtek driver for 8180
Date: Wed, 15 Sep 2004 19:54:18 -0500
User-Agent: KMail/1.6.2
References: <20040915161113.BVQI25194.lakermmtao01.cox.net@smtp.east.cox.net> <1095268473.6499.4.camel@dhollis-lnx.kpmg.com>
In-Reply-To: <1095268473.6499.4.camel@dhollis-lnx.kpmg.com>
Cc: dhollis@davehollis.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409151954.18035.tuxrocks@cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The realtek drivers have worked for me, but only (as you said) for 2.4.  They 
also don't support monitor mode, which I would like to use.
I had similar experiences with the sourceforge projects mentioned.  The 
rtl8180+sa2400 bailed with numerous warnings.  The project you mention might 
be the other one on sourceforge, rtl-ddp.  Things seemed to be moving, but 
then stalled.  It compiles and insmods but doesn't have the wireless 
extensions supported yet.  I'm sure everyone involved in the projects is 
busy, but I'm just trying to see if going out and buying a 20 or 30 dollar 
card that is supported would be my best bet.
On Wednesday 15 September 2004 12:14 pm, David Hollis wrote:
> I'm quite interested in this driver as well.  At the moment I'm stuck
> using the ndiswrapper to make the card work but it's not how I would
> like to do things long term.  I looked at the rtl8180+sa2400 driver at
> sourceforge and it seems to be the most promising but the code is in
> pretty bad shape.  It won't compile against a recent kernel using gcc
> 3.4 without a load of warnings and errors due to the coding style.  I
> also found a project (forget where exactly) that is focused on making
> the existing Realtek drivers work under 2.6 kernels.  The Realtek
> drivers do the typical link-to-precompiled-object bit and are designed
> for 2.4.  I haven't played with them myself so I don't know if they work
> or not.  I would really prefer a standard, well-written fully open
> driver (wouldn't we all!) that at worst requires a firmware binary to be
> loaded.  The prism54 and ipw2x00 drivers come to mind...
