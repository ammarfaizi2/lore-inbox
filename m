Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVBDNYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVBDNYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbVBDNYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:24:30 -0500
Received: from styx.suse.cz ([82.119.242.94]:3819 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S266369AbVBDNXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:23:38 -0500
Date: Fri, 4 Feb 2005 14:23:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050204132356.GG10424@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain> <m3lla64r3w.fsf@telia.com> <20050202141117.688c8dd3@localhost.localdomain> <Pine.LNX.4.58.0502022345320.18555@telia.com> <20050203064645.GA2342@ucw.cz> <m31xbxxqac.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m31xbxxqac.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 10:54:51PM +0100, Peter Osterlund wrote:

> Here it is, with the suggestions from Pete and Dmitry included. The
> patch does the following:
> 
> * Compensates for the lack of floating point arithmetic by keeping
>   track of remainders from the integer divisions.
> * Removes the xres/yres scaling so that you get the same speed in the
>   X and Y directions even if your screen is not square.
> * Sets scale factors to make the speed for synaptics and alps equal to
>   each other and equal to the synaptics speed from 2.6.10.
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>
 
Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
