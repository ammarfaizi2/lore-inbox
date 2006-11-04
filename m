Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753612AbWKDTHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbWKDTHU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbWKDTHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:07:20 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:31966 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1753612AbWKDTHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:07:19 -0500
Date: Sat, 04 Nov 2006 20:07:22 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: New filesystem for Linux
In-reply-to: <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <454CE4EA.7030500@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A76CC.6030003@cosmosbay.com>
 <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka a écrit :
>> The problem with a per_cpu biglock is that you may consume a lot of 
>> RAM for big NR_CPUS. Count 32 KB per 'biglock' if NR_CPUS=1024
> 
> Does one Linux kernel run on system with 1024 cpus? I guess it must fry 
> spinlocks... (or even lockup due to spinlock livelocks)

Not here in my house, but I was told such beasts exist somewhere on this planet :)

You can have a kernel compiled with NR_CPUS=1024, but still run it on your 
laptop, with a single CPU available...

