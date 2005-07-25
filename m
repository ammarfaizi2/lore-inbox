Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVGYR15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVGYR15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVGYR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:27:57 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:54539 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261393AbVGYR14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:27:56 -0400
Date: Mon, 25 Jul 2005 19:28:27 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2.6] I2C: Separate non-i2c hwmon drivers from i2c-core
 (2/9)
Message-Id: <20050725192827.0b166d1e.khali@linux-fr.org>
In-Reply-To: <20050725003551.GE9824@kroah.com>
References: <20050719233902.40282559.khali@linux-fr.org>
	<20050719234843.14cfb1ec.khali@linux-fr.org>
	<20050720042755.GD26552@kroah.com>
	<20050720234603.2b66560d.khali@linux-fr.org>
	<20050725003551.GE9824@kroah.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Ah, much better, thanks.  Sounds like a great plan, I'll go apply your
> patches in a day or so when I catch up from my travels.

OK, thanks.

Note that there are a few patches which you should apply before this
series, in particular Mark Hoffman's 3 hwmon class patches. There are no
hard dependencies between both series but applying them in order is
likely to ease your work.

You can take a look at my current stack here for reference:
http://khali.linux-fr.org/devel/i2c/linux-2.6/series

Not everything is i2c or hwmon related, but that should give you an idea
of which order you should apply them in to keep the noise to a minimum
level. There might be a number of individual patches that I did not post
yet, because I was waiting for you to apply Mark's stuff first. Just let
me know when you're done with the hwmon class patches and everything
else you might have on your end, and I'll post all other patches - after
I checked that they properly apply on top of what you have.

Thanks,
-- 
Jean Delvare
