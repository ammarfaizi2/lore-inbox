Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267399AbTAWXoW>; Thu, 23 Jan 2003 18:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTAWXoV>; Thu, 23 Jan 2003 18:44:21 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:21304
	"EHLO bluetooth.WNI.AD") by vger.kernel.org with ESMTP
	id <S267399AbTAWXoV>; Thu, 23 Jan 2003 18:44:21 -0500
Message-ID: <3E308120.1090704@WirelessNetworksInc.com>
Date: Thu, 23 Jan 2003 16:56:16 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zsolt Babak <zod@sch.bme.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
References: <3E2C8EFF.6020707@tin.it> <20030121235339.GB4794@yzero> <20030123221428.GA31588@gandalf.sch.bme.hu>
In-Reply-To: <20030123221428.GA31588@gandalf.sch.bme.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jan 2003 23:53:32.0500 (UTC) FILETIME=[A2B3B140:01C2C33A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A glitch on any interrupt line, will cause IRQ7 to trigger on the 8259A. 
  It is a documented 'feature' and is not really useful, but software 
has to handle it gracefully.

Zsolt Babak wrote:
>>i get it on my thinkpad 560e when using a linksys ne2k pcmcia card. i only
>>get the message once, and it's triggered after a few seconds of high
>>throughput (fast, fd).
>>
> 
> Same here with an Acer TravelMate laptop, with an smc pcmcia network card. The
> message occures only once at high network load. But the system is quite
> stable, so I didn't bother to track this down...
> 
> Oh, and the laptop is based on Ali, not on VIA chips.
> 
>     Zsolt.


