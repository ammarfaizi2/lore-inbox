Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSLQGia>; Tue, 17 Dec 2002 01:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264760AbSLQGia>; Tue, 17 Dec 2002 01:38:30 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:6665 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264749AbSLQGi3>; Tue, 17 Dec 2002 01:38:29 -0500
Message-Id: <200212170640.gBH6dws16015@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Xavier LaRue <paxl@videotron.ca>, linux-kernel@vger.kernel.org
Subject: Re: Dual P3 550 Katmai Bug
Date: Tue, 17 Dec 2002 09:29:15 -0200
X-Mailer: KMail [version 1.3.2]
References: <20021216182724.30ba0aa6.paxl@videotron.ca>
In-Reply-To: <20021216182724.30ba0aa6.paxl@videotron.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 December 2002 21:27, Xavier LaRue wrote:
> Hi all,
> As I asked later this day.. my L2 cache is'nt detected on my dual p3
> 550. But I have another fuzy problem,

That's not a big loss. Undetected cache works as good as detected ;)

> all application take more cpu power in smp ( like xmms who was taking
> .3% take around 3% under and SMP kernel ( I use ps axuf to say this )

SMP operation incur locking overhead.

> .. I think the bug came from the kernel(2.4.18) since I build the
> smp kernel before adding my second processor and it was using as much
> cpu .. and another fuzzy problem, Sometime ( read one time at each 15
> min ) the cpu0 OR cpu1 get more and more loaded till it get 100% of
> cpu load and then it reget back to 0%.

Can you look which app does this? I see similar thing on SMP kernel
running on single Duron. xmms does this. xmms bug?

> My question is .. do update my kernel to a 2.4.20 ( or another
> version ) should fix my problem, also could upgrading to another
> kernel should debug my cache problem ?? BTW, I'm not using an Debian
> stock kernel.. I build it yesterday from real scratch.. (make clean
> dep; make bzImage;... )

Try newer kernel, cache detection was discussed here recently.
Or search archives...
--
vda
