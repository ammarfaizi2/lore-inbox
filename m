Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbVJ1C11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVJ1C11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 22:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVJ1C11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 22:27:27 -0400
Received: from xenotime.net ([66.160.160.81]:34469 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965055AbVJ1C11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 22:27:27 -0400
Date: Thu, 27 Oct 2005 19:27:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: The "best" value of HZ
Message-Id: <20051027192724.350dcc41.rdunlap@xenotime.net>
In-Reply-To: <200510280118.42731.cloud.of.andor@gmail.com>
References: <200510280118.42731.cloud.of.andor@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005 01:18:41 +0200 Claudio Scordino wrote:

> Hi,
> 
>     during the last years there has been a lot of discussion about the "best" 
> value of HZ... On i386 was 100, then became 1000, and finally was set to 250.
> I'm thinking to do an evaluation of this parameter using different 
> architectures.
> 
> Has anybody thought to give the possibility to modify the value of HZ at boot 
> time instead of at compile time ? This would allow to easily test different 
> values on different machines and create a table containing the "best" value 
> for each architecture...  At this moment, instead, we have to recompile the 
> kernel for each different value :(
> 
> Do you think there would be much work to do that ? 

Not a lot.  Could be useful.

> Do you think it would be a desired feature the knowledge of the best value for 
> each architecture with more precision ?

In this thread (around 2005-july-14)
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
there was some interest in that, and the beginnings of a patch.
But the dynamic tick patch seems to have sidelined this one.

---
~Randy
