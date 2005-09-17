Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVIQWVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVIQWVG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 18:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVIQWVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 18:21:05 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:32465 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1751212AbVIQWVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 18:21:04 -0400
Message-ID: <432C941F.10501@linuxtv.org>
Date: Sun, 18 Sep 2005 02:09:35 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts (2)
References: <432C344D.1030604@linuxtv.org> <20050917215646.78a05044.vsu@altlinux.ru> <432C5F93.80506@linuxtv.org> <20050917191058.GJ11302@procyon.home> <432C6E67.7030602@linuxtv.org> <20050917194940.GK11302@procyon.home>
In-Reply-To: <20050917194940.GK11302@procyon.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: manu@kromtek.com
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:

>>
>>	free_irq(pdev->irq, pdev);
>>    
>>
>
>This should be
>
>	free_irq(pdev->irq, mantis);
>
>  
>
Ah, thanks a lot. That solves it.
Thanks for your time.


Regards,
Manu

