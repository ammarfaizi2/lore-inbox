Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUB1LQg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 06:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbUB1LQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 06:16:36 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:53140 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261228AbUB1LQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 06:16:34 -0500
Message-ID: <40407847.7040403@cyberone.com.au>
Date: Sat, 28 Feb 2004 22:15:19 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: sched domains kernbench improvements
References: <200402282159.58452.kernel@kolivas.org>
In-Reply-To: <200402282159.58452.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>Hi Nick
>
>
>>So it is more a matter of tuning than anything fundamental
>>
>
>Geez I know how you feel... :-D
>
>
>I tried it on the X440 with sched smt disabled
>
>better than before but still slower than vanilla on half load; however better 
>than vanilla on optimal and full load now! I wonder whether the worse result 
>on half load is as relevant since this is 8x HT cpus?
>
>

Thanks. Yep the drop off at half load is to be expected with
CONFIG_SCHED_SMT turned off.

