Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUKIULt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUKIULt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUKIULt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:11:49 -0500
Received: from stacja.kursor.pl ([80.55.191.138]:43988 "EHLO stacja.lan")
	by vger.kernel.org with ESMTP id S261673AbUKIULm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:11:42 -0500
Date: Tue, 9 Nov 2004 21:11:18 +0100 (CET)
From: Janusz Dziemidowicz <rraptorr@nails.eu.org>
X-X-Sender: rraptorr@cube.lan
To: Oded Shimon <ods15@ods15.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: RivaFB on Geforce FX 5200
In-Reply-To: <200411091458.06585.ods15@ods15.dyndns.org>
Message-ID: <Pine.LNX.4.61.0411092106150.2007@cube.lan>
References: <200411091458.06585.ods15@ods15.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Oded Shimon wrote:

> One problem is when switching from X back to FB console, I can still see the X
> cache (at the different res and color depth, it simply looks like noise...),
> until some kind of modification has happenned in the console.
> If i run any kind of program which modifies the frame buffer, for ex. fbset or
> ppmtofb, the FB console is irreversibly ruined until reboot. (it looks mostly
> like noise which you can barely make out the console text underneath).
> The worst problem - no penguin at boot up. :(  There is a black bar in the
> area where its supposed to be, but no image...
> My guess is the cause for most of these problem is me causing the driver to
> think it can support my card, when it doesn't really have all the kinks
> sorted out...

Hi,
I assume You are trying to use rivafb with nvidia binary drivers? If 
that's the case, then here's an excerpt from NVIDIA README file:

Q: My system hangs when vt-switching if I have rivafb enabled.

A: Using both rivafb and the NVIDIA kernel module at the same time is
    currently broken.  In general, using two independent software drivers
    to drive the same piece of hardware is a bad idea.

So it is unlikely to make this two drivers to work together.

--
Janusz Dziemidowicz
rraptorr@nails.eu.org
