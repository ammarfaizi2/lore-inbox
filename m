Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbTBOXPz>; Sat, 15 Feb 2003 18:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbTBOXPz>; Sat, 15 Feb 2003 18:15:55 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:43591
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265400AbTBOXPy>; Sat, 15 Feb 2003 18:15:54 -0500
Date: Sat, 15 Feb 2003 18:24:22 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: tbench as a load - DDOS attack?
In-Reply-To: <200302161007.25149.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.50.0302151823130.16012-100000@montezuma.mastecende.com>
References: <200302161007.25149.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003, Con Kolivas wrote:

> 
> Zwane M suggested using tbench as a load to test one of his recent patches and 
> gave me the idea to try using tbench_load in contest. Here are the first set 
> of results I got while running tbench 4 continuously (uniprocessor machine):
> 
> tbench_load:
> Kernel         [runs]   Time    CPU%    
> test2420            1   180     38.9    
> test2561            1   970     7.7   
> 
> This is a massive difference. Sure tbench was giving better numbers on 2.5.61 
> but it caused a massive slowdown. I wondered whether this translates into 
> being more susceptible to ping floods or DDOS attacks? You should have seen 
> tbench 16 - 3546 seconds!
> 
> comments?

Are you running this via loopback? Can you send a profile during the 
2.4.20 run?

Thanks,
	Zwane

-- 
function.linuxpower.ca
