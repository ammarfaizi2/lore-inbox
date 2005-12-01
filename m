Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVLAQwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVLAQwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVLAQwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:52:50 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:34265 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932330AbVLAQwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:52:49 -0500
Date: Thu, 1 Dec 2005 17:52:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: ray-gmail@madrabbit.org
cc: Kyle Moffett <mrmacman_g4@mac.com>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0512011740080.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0512010118200.1609@scrub.home>  <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
  <Pine.LNX.4.61.0512011352590.1609@scrub.home>
 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2005, Ray Lee wrote:

> Actually, no you won't. The athlete will say "A timeout? Something out
> of the ordinary happened, and coach wants me to go to the sidelines to
> talk." Timeouts are unexpected and exceptional, whether you're an
> athlete or a piece of code. On the other hand, they have a timer that
> everyone *expects* to expire at the end of the quarter or game.

Please be precise, there is of course a common base, but it's not the 
same. In sports a timeout is the actual event that interrupts something. 
In code it's a time _period_ until an exceptional event. A timer delivers 
an asynchronous event after a specified timeout, so they're always 
"unexpected and exceptional". (You can of course constantly poll the timer 
to make it a little less unexpected, but then you don't really need to set 
a timer in first place.)

bye, Roman
