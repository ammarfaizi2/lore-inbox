Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVDVR2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVDVR2b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVDVR2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:28:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:18666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262076AbVDVR2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:28:23 -0400
Date: Fri, 22 Apr 2005 10:26:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tomi Lapinlampi <lapinlam@vega.lnet.lut.fi>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       rth@twiddle.net, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
In-Reply-To: <20050422144047.GY607@vega.lnet.lut.fi>
Message-ID: <Pine.LNX.4.58.0504221024470.2344@ppc970.osdl.org>
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050421204354.GF3828@stusta.de>
 <20050422072858.GU607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi>
 <20050422144047.GY607@vega.lnet.lut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Apr 2005, Tomi Lapinlampi wrote:
> 
> Although the tgafb driver compiles with the above patch, it shows
> similar behaviour as before: The kernel loads, the monitor comes alive
> but the screen stays completely blank.
> The last kernel that worked was 2.6.8.1. I've tested with 2.6.{9,10,11}

Can you try to figure out where in between 2.6.8->2.6.9 things broke? Even 
just a fairly simple binary search on the nightly snapshots should get you 
pretty easily down to within one day or so..

Most people don't have tga hardware. I don't think even most alpha users 
have it, and I think it's unheard of outside of alpha. So I'm afraid that 
there's not a lot of people around who can debug it without having a very 
clear starting point..

		Linus
