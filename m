Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTKEK2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTKEK2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:28:15 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:22464 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262788AbTKEK2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:28:12 -0500
Message-ID: <3FA8D059.7010204@cyberone.com.au>
Date: Wed, 05 Nov 2003 21:26:33 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA69CDF.5070908@gmx.de> <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de>
In-Reply-To: <3FA8CCF9.6070700@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Prakash K. Cheemplavam wrote:

>
> SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the mouse 
> stutters slighty when burning (in atapi mode). I am now using as 
> sheduler. Shoudl I try deadline or do you this it is something else? 
> Should I open a new topic?
>

This is more likely to be the CPU scheduler or something holding
interrupts for too long. Are you running anything at a modified
priority (nice)?

