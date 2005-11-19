Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVKSTKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVKSTKX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVKSTKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:10:23 -0500
Received: from styx.suse.cz ([82.119.242.94]:9931 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750737AbVKSTKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:10:22 -0500
Date: Sat, 19 Nov 2005 20:10:12 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Larry.Finger@lwfinger.net" <Larry.Finger@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA mode locked off when via82cxxx ide driver built as module in 2.6.14
Message-ID: <20051119191012.GA19286@midnight.ucw.cz>
References: <111920051859.9281.437F7619000700AC0000244121603763169D0A09020700D2979D9D0E04@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111920051859.9281.437F7619000700AC0000244121603763169D0A09020700D2979D9D0E04@att.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 06:59:37PM +0000, Larry.Finger@lwfinger.net wrote:
> My HP ze1115 notebook uses the via82cxxx ide driver. If I configure the kernel build to make that driver as a module, the driver is correctly added to initrd and is loaded at boot time; however, DMA mode is turned off. It cannot be turned on even if I use an 'hdparm -d1 /dev/hda' command.
> 
> Is this a bug, or do I need some kind of IDE=XXX boot command? As expected, system performance in this mode is horrible.
 
What chipset does your notebook use? 'lspci -vv' should give a good
answer.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
