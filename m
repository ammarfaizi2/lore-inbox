Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVBKUkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVBKUkV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVBKUkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:40:20 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:18098 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262330AbVBKUkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:40:16 -0500
Date: Fri, 11 Feb 2005 21:40:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211204047.GA7112@ucw.cz>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net> <20050211011609.GA27176@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211011609.GA27176@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 05:16:09PM -0800, Greg KH wrote:

> > Please, continue this project and encourage distros to switch to it (when 
> > it exceeds hotplug in functionality and stability). Ubuntu currently is 
> > trying to reduce boot time, and I bet something like this would factor in 
> > (even a few seconds helps).
> 
> Thanks for the kind words.
> 
> All distros are trying to reduce boot time.  I don't think that the
> module autoload time has been fingered as taking any serious ammount of
> boot time due to it happening in the background of everything else.

Hotplug scripts were identified as one of the major culprits of slow boot
when we did the analysis for SuSE 9.2. They took 40+ seconds from the
total boot time.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
