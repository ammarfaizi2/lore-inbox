Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVBDNZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVBDNZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbVBDNZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:25:34 -0500
Received: from styx.suse.cz ([82.119.242.94]:53994 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262262AbVBDNUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:20:39 -0500
Date: Fri, 4 Feb 2005 14:20:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/4] Add support for Synaptics touchpad scroll wheels
Message-ID: <20050204132055.GF10424@ucw.cz>
References: <m34qgz9pj5.fsf@telia.com> <m3zmyr8avm.fsf@telia.com> <m3vf9f8asf.fsf_-_@telia.com> <m3r7k38apr.fsf_-_@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3r7k38apr.fsf_-_@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 11:36:48AM +0100, Peter Osterlund wrote:
> Some Synaptics touchpads have a middle mouse button that also works as
> a scroll wheel.  Scroll data is reported as packets with w == 2 and
> the scroll amount in byte 1, treated as a signed character.  For some
> reason, the smallest possible wheel movement is reported as a scroll
> amount of 4 units.  This amount is typically spread out over more than
> one packet, so the driver has to accumulate scroll delta values to
> correctly deal with this.
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>
> ---
 
Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
