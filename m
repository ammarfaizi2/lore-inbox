Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264572AbUESVsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264572AbUESVsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 17:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUESVsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 17:48:30 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:14354 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264572AbUESVs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 17:48:29 -0400
Date: Wed, 19 May 2004 22:47:55 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: David Eger <eger@theboonies.us>
cc: akpm@osdl.org,
       Linux Frame Buffer Dev 
	<linux-fbdev-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] FB accel capabilities patch
In-Reply-To: <1085002775.40abd417121b0@mail.theboonies.us>
Message-ID: <Pine.LNX.4.44.0405192242070.28783-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Will it suffice to add
> 
> #define FBINFO_FLAG_MODULE FBIF_MODULE
> 
> for backwards compatibility?
> 
> I'd prefer the new flags to be FBIF_*, as the identifier
> FBINFO_FLAG_HWACCEL_COPYAREA seems sorta long to me...

I agree. I dropped the _FLAG_ part. It just more readable with FBINFO.
If you have no problem with that I will add it to the fbdev-2.6 BK tree. 
Andrew has asked me to move everything to a BK tree for him to pull.

> I'll sync with linus's bk tomorrow and try to rework my main patch; the
> "mainline" patch I posted was against his bk shortly after 2.6.6...

I will setup the new fbdev-2.6 BK repos tonight for Andrew so try tomorrow 
to sync against that tree. 

> I take it this is in addition to your con2fb patch I have posted at that web
> address?

Yes. I see that patch works like a charm for you. :-)


