Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317686AbSGJXrp>; Wed, 10 Jul 2002 19:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317687AbSGJXro>; Wed, 10 Jul 2002 19:47:44 -0400
Received: from jalon.able.es ([212.97.163.2]:48537 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S317685AbSGJXrl>;
	Wed, 10 Jul 2002 19:47:41 -0400
Date: Thu, 11 Jul 2002 01:50:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Andrew Morton <akpm@zip.com.au>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020710235020.GA2113@werewolf.able.es>
References: <Pine.LNX.4.44.0207101559460.5067-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0207101559460.5067-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Thu, Jul 11, 2002 at 00:01:08 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.11 Thunder from the hill wrote:
>Hi,
>
>On Wed, 10 Jul 2002, Andrew Morton wrote:
>> That makes a ton of sense.
>> 
>> > But on the other hand, increasing HZ has perf/latency benefits, yes? Have
>> > these been quantified?
>> 
>> Not that I'm aware of.  And I'd regard any such claims with some
>> scepticism.
>> 
>> > I'd either like to see a HZ that has balanced
>> > power/performance, or could we perhaps detect we are on a system that cares
>> > about power (aka a laptop) and tweak its value at runtime?
>
>Want a config option? Either int or bool (CONFIG_LOW_HZ). It's not too 
>much effort.
>

How about a <boot> option ? linux hz=[low,high]

It is runtime, but just one time.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc1-jam2, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.7mdk)
