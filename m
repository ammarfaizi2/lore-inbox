Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290821AbSAYWJG>; Fri, 25 Jan 2002 17:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290822AbSAYWI4>; Fri, 25 Jan 2002 17:08:56 -0500
Received: from www.transvirtual.com ([206.14.214.140]:58887 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290821AbSAYWIv>; Fri, 25 Jan 2002 17:08:51 -0500
Date: Fri, 25 Jan 2002 14:08:43 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Corey Minyard <minyard@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: LED device driver
In-Reply-To: <3C51D44B.2050402@acm.org>
Message-ID: <Pine.LNX.4.10.10201251403490.557-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A lot of boards have LEDs on the front, it is useful to be able to 
> control these LEDs from userland.  I have implemented a start at a 
> device driver front-end for this that gives a generic interface.  I'd 
> appreciate comments on it.  I have not tied things like the num lock 
> LEDs to this, but that might be doable later.

At a look at the input api (include/linux/input.h). Since keyboards have
leds we implemented a very basic api for this. 



