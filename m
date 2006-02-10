Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWBJEpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWBJEpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWBJEpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:45:22 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:44996 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751002AbWBJEpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:45:21 -0500
Message-ID: <43EC1A54.2030709@linuxtv.org>
Date: Thu, 09 Feb 2006 23:45:08 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andreas Oberritter <obi@linuxtv.org>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/media/dvb/frontends/mt312.c: cleanups
References: <20060204233751.GH4528@stusta.de> <43E5A23D.8080107@linuxtv.org> <20060207223844.GC3524@stusta.de>
In-Reply-To: <20060207223844.GC3524@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - update the Kconfig help to mention the VP310
> - merge vp310_attach and mt312_attach into a new vp310_mt312_attach
>   to remove some code duplication
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/media/dvb/b2c2/flexcop-fe-tuner.c |    2 
>  drivers/media/dvb/frontends/Kconfig       |    2 
>  drivers/media/dvb/frontends/mt312.c       |  116 ++++++++--------------
>  drivers/media/dvb/frontends/mt312.h       |    6 -
>  4 files changed, 48 insertions(+), 78 deletions(-)

Thanks, Adrian.  I've applied this to my tree.

Regards,

Michael Krufky
