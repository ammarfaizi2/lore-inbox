Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUCDItP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 03:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUCDItP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 03:49:15 -0500
Received: from mail.convergence.de ([212.84.236.4]:8846 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261564AbUCDItO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 03:49:14 -0500
Message-ID: <4046ED88.6020302@convergence.de>
Date: Thu, 04 Mar 2004 09:49:12 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] DVB stv0299.c: remove unused variable
References: <20040303215549.GJ24510@fs.tum.de>
In-Reply-To: <20040303215549.GJ24510@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,

On 03/03/04 22:55, Adrian Bunk wrote:
> The stv0299 DVB frontend update in Linus' 2.6 tree introduced a 
> completely unused variable:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/media/dvb/frontends/stv0299.o
> drivers/media/dvb/frontends/stv0299.c: In function `tsa5059_set_tv_freq':
> drivers/media/dvb/frontends/stv0299.c:356: warning: unused variable `i'
> ...
> 
> <--  snip  -->
> 
> 
> The following patch removes this variable:
> 
> 
> --- linux-2.6.4-rc1-mm2/drivers/media/dvb/frontends/stv0299.c.old	2004-03-03 22:51:19.000000000 +0100
> +++ linux-2.6.4-rc1-mm2/drivers/media/dvb/frontends/stv0299.c	2004-03-03 22:52:57.000000000 +0100

Thanks. The patch is already in our local CVS and will be in the next 
DVB update.

Please CC the official "maintainer" address 
<linux-dvb-maintainer@linuxtv.org> the next time. Thanks!

CU
Michael.
