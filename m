Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUBHWcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUBHWcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:32:23 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:21985 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264238AbUBHWcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:32:22 -0500
Date: Sun, 8 Feb 2004 23:32:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: aeriksson@fastmail.fm
Cc: Murilo Pontes <murilo_pontes@yahoo.com.br>, linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040208223218.GA16718@ucw.cz>
References: <20040208215935.GA13280@ucw.cz> <20040208221933.92D0B3F1B@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208221933.92D0B3F1B@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 11:19:32PM +0100, aeriksson@fastmail.fm wrote:

> > > Problem still occurs :-(
> > 
> > I have good news - I've managed to reliably reproduce the bug on my
> > machine and that means I now have a good chance to find and fix it.
> > 
> 
> Another data point. I just tried switching to a non-preempt kernel as
> was suggested by someone. The problem still occurs.

You may want to try killing the mod_timer() calls in i8042.c. That'll
probably help.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
