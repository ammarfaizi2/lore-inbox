Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTCTQ4b>; Thu, 20 Mar 2003 11:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbTCTQ4b>; Thu, 20 Mar 2003 11:56:31 -0500
Received: from mail.zmailer.org ([62.240.94.4]:62095 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S261427AbTCTQ4a>;
	Thu, 20 Mar 2003 11:56:30 -0500
Date: Thu, 20 Mar 2003 19:07:28 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Bernd Petrovitsch <bernd@gams.at>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bottleneck on /dev/null
Message-ID: <20030320170728.GQ29167@mea-ext.zmailer.org>
References: <Pine.LNX.4.33.0303201720170.8831-100000@gans.physik3.uni-rostock.de> <28588.1048178012@frodo.gams.co.at> <Pine.LNX.4.53.0303201150140.4241@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0303201150140.4241@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 12:01:06PM -0500, Richard B. Johnson wrote:
...
> Yes. That's better. It may have been a diagnostic error
> in the code of the first person reporting this --also.
> 
> The data-rate is so high that I might have wrapped several
> times! I didn't think it would be that high, only 2 to 3
> gigibyte/second, not over 4 Gb/s (with 130MHz RAM no less)

  Furthermore,  in Linux you are really measuring syscall overhead
  to  "/dev/null" write,  which does never do memory transfers of
  any kind from user-space to kernel.

... 
> Its interesting that the data-rate is higher with the network
> plugged in and getting all those M$ broadcast messages. But, as
> expected, its more stable without.

  Quite so.

> Cheers,
> Dick Johnson

/Matti Aarnio
