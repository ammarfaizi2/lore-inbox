Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbULUSpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbULUSpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULUSpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:45:39 -0500
Received: from [195.23.16.24] ([195.23.16.24]:60553 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261851AbULUSpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:45:19 -0500
Message-ID: <41C86F2A.7020409@grupopie.com>
Date: Tue, 21 Dec 2004 18:44:58 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesse <jessezx@yahoo.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: Gurus, a silly question for preemptive behavior
References: <20041221183216.56558.qmail@web52601.mail.yahoo.com>
In-Reply-To: <20041221183216.56558.qmail@web52601.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.25; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jesse wrote:
> Con:
> 
>    thank you for your prompt reply in the holiday
> season. 
> 
>    My point is: Even kernel 2.4 is not 
> preemptive, the latence should be very
> minimal.(<300ms)
> why user space application with low nice priority
> can't be effectively interrupted and holds the CPU
> resource since all user space application is
> preemptive?

If your process has got work to do and has a higher priority than other 
processes, it gets to run. If you don't want this behavior, don't give 
it such a high priority.

If you want low latency to do some quick high priority task, just do it 
quickly and relinquish the processor, instead of hogging it.

What are you trying to accomplish, anyway?

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu
