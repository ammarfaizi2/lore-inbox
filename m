Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267794AbUHJWnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267794AbUHJWnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267795AbUHJWnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:43:23 -0400
Received: from digitalimplant.org ([64.62.235.95]:1494 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267794AbUHJWnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:43:12 -0400
Date: Tue, 10 Aug 2004 15:42:59 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: David Brownell <david-b@pacbell.net>
cc: Pavel Machek <pavel@suse.cz>, "" <linux-kernel@vger.kernel.org>,
       "" <benh@kernel.crashing.org>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <200408101136.38387.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.50.0408101541580.28789-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
 <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
 <20040810101308.GE9034@atrey.karlin.mff.cuni.cz> <200408101136.38387.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, David Brownell wrote:

> Keep in mind that to properly quiesce a USB controller, you've
> got to quiesce every driver for every device hooked up to
> that USB bus.  There's no escaping the bottom-up suspend
> or top-down-resume processes, which makes me wonder
> how Patrick's proposed patch can work for it...

Hey, I'm willing to capitulate. :)

I will change the ordering, as well as the proposed change in the last
email.


	Pat
