Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUBLGli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 01:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265754AbUBLGli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 01:41:38 -0500
Received: from dp.samba.org ([66.70.73.150]:44759 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263462AbUBLGlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 01:41:37 -0500
Date: Thu, 12 Feb 2004 17:37:44 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, benh@ozlabs.org
Subject: Re: PPC64 PowerMac G5 support available
Message-ID: <20040212063743.GE25922@krispykreme>
References: <1076563481.2285.167.camel@gaston> <Pine.LNX.4.58.0402112223480.5816@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402112223480.5816@home.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Actually, at least for me, the _old_ radeon driver works without any 
> modifications at all in text mode. Rock stable image, unlike the new one 
> that needed the clock fixes.
> 
> But trying to start X hangs the system hard, which may well be an issue 
> with the old radeonfb. Whenever you have a new driver, I will test.

Chances are you are using the openfirmware FB stuff, not radeonFB. Ben
suggested checking out /proc/fb or dmesg to be sure.

Anton
