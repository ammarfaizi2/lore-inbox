Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263091AbVCDUpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbVCDUpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbVCDUmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:42:44 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62885 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S263096AbVCDUfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:35:03 -0500
Date: Fri, 4 Mar 2005 21:35:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Hans-Christian Egtvedt <hc@mivu.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Message-ID: <20050304203537.GA2550@ucw.cz>
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no> <200503041403.37137.adobriyan@mail.ru> <d120d50005030406525896b6cb@mail.gmail.com> <1109953224.3069.39.camel@charlie.itk.ntnu.no> <d120d50005030408544462c9ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005030408544462c9ea@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:54:18AM -0500, Dmitry Torokhov wrote:

> No, not physical sizes. I was wondering if soe touchscreens are
> reporting let's say actual coordinates from 1100-3600 and others from
> 600-3850, instead of full 0-4096. Is there a way to query the hardware
> and find the actual min and max for a device so it can be reported to
> userspace.

Resistive touchscreens, due to their voltage-divider nature have
near-full range all the time, independent of the controller and sensor
combination, so setting min to 0 and max to 4096 is OK.

> P.S. When you post the updated version could you please CC Vojtech
> Pavlik <vojtech@suse.cz> as he is the current input system maintainer
> and linux-input mailing list at linux-input@atrey.karlin.mff.cuni.cz.
 
Yes, please. ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
