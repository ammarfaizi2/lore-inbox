Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTHTOYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTHTOYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:24:08 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:12756 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261982AbTHTOYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:24:03 -0400
Subject: Re: Can't read fan-speeds from i2c
From: Stian Jordet <liste@jordet.nu>
To: Charles Lepple <clepple@ghz.cc>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F42E16E.8070809@ghz.cc>
References: <1061324213.708.6.camel@chevrolet.hybel>
	 <3F42E16E.8070809@ghz.cc>
Content-Type: text/plain
Message-Id: <1061389453.688.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 16:24:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 20.08.2003 kl. 04.48 skrev Charles Lepple:
> Stian Jordet wrote:
> > I have a Asus CUV266-DLS, which uses the as99127f chipset. Everything
> > seems to work as it is supposed to, except for fan-speeds. They say 0.
> > Is that supposed behaviour since the as99127f doesn't have any
> > datasheets, or am I doing something wrong?
> 
> Have you tried adjusting the fan divisors (fan_div* in 
> /sys/bus/i2c/devices/*)? Keep multiplying the fan divisor by two, and 
> check the fan_input* devices-- you may have slow fans (or divide-by-two 
> speed sensors), and you might need a longer sampling interval to see the 
> lower speed.

Wow, that worked! Thank you very much :) I would never have found this
out without you :) My fans are rather slow, so that might have been the
problem. Anyway, thank you :)

Best regards,
Stian

