Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUA1ICQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 03:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbUA1ICQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 03:02:16 -0500
Received: from zeus.gup.uni-linz.ac.at ([140.78.104.2]:41133 "HELO
	zeus.gup.uni-linz.ac.at") by vger.kernel.org with SMTP
	id S265833AbUA1ICP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 03:02:15 -0500
Message-ID: <40176C85.90009@gup.jku.at>
Date: Wed, 28 Jan 2004 09:02:13 +0100
From: Martin Polak <mpolak@gup.jku.at>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.5) Gecko/20031117
X-Accept-Language: de-at, de-de, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP AMD64 (Tyan S2882) problems.
References: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel> <p73fze1fdk4.fsf@nielsen.suse.de>
In-Reply-To: <p73fze1fdk4.fsf@nielsen.suse.de>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Jan Kasprzak <kas@informatics.muni.cz> writes:
> 
> You don't say if you run a 32bit or a 64bit kernel. I will assume 64bit.
>  
> 
>>Is it normal? How can I set up some IRQ balancing (or at least hard-wire
>>3ware for CPU1 and eth0 for CPU0)?
> 
> 
> Run irqbalanced
>  
> 
Well I posted that thing two weeks ago, occuring on a dual 240 
K8T-Master from MSI, and yes: running irqbalance works fine, but still I 
believe that there is some sort of weirdness in initialization code of 
the kernel (2.6), because on 2.4 Kernels smp-affinity defaults to every 
cpu and on 2.6 it doesnt.

Martin Polak

