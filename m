Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVADU7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVADU7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVADU7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:59:13 -0500
Received: from holomorphy.com ([207.189.100.168]:28811 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261842AbVADU6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:58:36 -0500
Date: Tue, 4 Jan 2005 12:55:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104205513.GU2708@holomorphy.com>
References: <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com> <20050104165301.GF3097@stusta.de> <20050104195725.GQ2708@holomorphy.com> <20050104203444.GL3097@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104203444.GL3097@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 09:34:44PM +0100, Adrian Bunk wrote:
> <--  snip  -->
> config BLK_DEV_UB
>         tristate "Low Performance USB Block driver"
>         depends on USB
>         help
>           This driver supports certain USB attached storage devices
>           such as flash keys.
> 
>           If unsure, say N.
> <--  snip  -->
> Call me naive, but at least for me it wouldn't have been obvious that 
> this option cripples the usb-storage driver.
> The warning that this option cripples the usb-storage driver was added 
> after people who accidentially enabled this option ("it can't harm") 
> in 2.6.9 swamped the USB maintainers with bug reports about problems 
> with their storage devices.

The "it can't harm" assumption was flawed. Minimal configs are best for
a reason. Inappropriate options turned on can and always will be able
to take down your box and/or render some devices inoperable.

-- wli
