Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWCXHZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWCXHZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWCXHZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:25:37 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:3335 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751562AbWCXHZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:25:36 -0500
Date: Fri, 24 Mar 2006 08:26:00 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Christopher Hoover" <ch@murgatroid.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up magic numbers in i2c_parport.h
Message-Id: <20060324082600.ca9f9796.khali@linux-fr.org>
In-Reply-To: <000e01c64efd$cae7f750$8401000a@fakie>
References: <20060323205617.38e02afe.khali@linux-fr.org>
	<000e01c64efd$cae7f750$8401000a@fakie>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

> > Beeuh. These macros don't really help. They actually make the lines
> > longer! I'm not taking this change, sorry.
> 
> If I kill off the macros but continue to use C99 structure initializers,
> which is I believe is the proper kernel coding style today, the lines are
> going to get even longer.  Is that OK?
> 
> Or are you asking for the patch w/o macros and w/o C99 structure
> initializers?
> 
> I can/will do either.  Just let me know what is acceptable a priori.

I don't think C99 initializers are needed here, the structure is pretty
simple and is also defined in the same file, a few lines above all its
instance declarations. So I am indeed asking for a patch w/o macros and
w/o C99 structure initializers, unless someone objects.

Thanks,
-- 
Jean Delvare
