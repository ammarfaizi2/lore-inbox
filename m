Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271084AbUJUXRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271084AbUJUXRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271115AbUJUXQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:16:00 -0400
Received: from gprs214-34.eurotel.cz ([160.218.214.34]:44931 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S271079AbUJUXAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:00:42 -0400
Date: Fri, 22 Oct 2004 01:00:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041021230027.GA24762@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB600328792F@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600328792F@scsmsx403.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >The rest of the code you have above seems superfluous to me as we have 
> >never needed to do that. Then again we boot the card using the BIOS 
> >emulator, which is different because it runs within a 
> >protected machine 
> >state.
> >
> >Have you taken a look at the X.org code? They have code in 
> >there to POST 
> >the video card also (either using vm86() or the BIOS emulator).
> >
> 
> I have done some experiments with this video post stuff.
> I think this should be done using x86 emulator rather than doing 
> in real mode. The reason being, with an userlevel emulator we can call
> it at different times during resume. The current real mode videopost
> does 

Actually Ole Rohne has patch that allows you to call real mode any
time you want.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
