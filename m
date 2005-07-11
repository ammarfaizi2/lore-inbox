Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVGKQcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVGKQcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGKQXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:23:10 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:38098 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S262092AbVGKQVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:21:46 -0400
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested?
	(Userspace accelerometer viewer)
From: Dave Hansen <dave@sr71.net>
To: Paul Sladen <thinkpad@paul.sladen.org>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
References: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 09:21:35 -0700
Message-Id: <1121098895.15095.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 10:42 +0100, Paul Sladen wrote:
> The sensor gives us two 10-bit AD values (corresponding to 0..1 volts on the
> ADI chip), temperature (Celsius) and three status bits indicating:
> 
>   * lid open/closed

Which bit did you find this in?  I haven't tried with the lid closed.

>   * keyboard activity
>   * nipple movement

Technically, it's mouse movement :)  I think it gets set on my T41p when
I'm using the touchpad.

> On the X40 I borrowed (thanks Robert McQueen), at rest the outputs hover
> around 512 (0x200).  Gravity is supposed to fall off in a sine-wave during
> rotation, but I found that:
> 
>   theta = (N - 512) * 0.5
> 
> provides a surprisingly good approximation for pitch/roll values in degrees
> in the range (-90..+90) so I think the sensor can do ~= +/-2.5G .

Interesting.  

-- Dave

