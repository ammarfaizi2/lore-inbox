Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136298AbRD1BIJ>; Fri, 27 Apr 2001 21:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136303AbRD1BH7>; Fri, 27 Apr 2001 21:07:59 -0400
Received: from chromium11.wia.com ([207.66.214.139]:1293 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S136298AbRD1BHv>; Fri, 27 Apr 2001 21:07:51 -0400
Message-ID: <3AEA18CC.98B0AF26@chromium.com>
Date: Fri, 27 Apr 2001 18:11:40 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Smith <x@xman.org>,
        Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AEA0C52.FA7CE1F1@chromium.com> <15082.5024.493177.69148@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In both cases (X15 and TUX) the CPU utilization is 100%

There are no IO bottlenecks on disk or on the net side.

I think that the major bottleneck is the speed of RAM and the PCI bus, wait
cycles.

We are basically going at the speed of the hardware.

 - Fabio

"David S. Miller" wrote:

> Fabio Riccardi writes:
>  > On my Dell 4400 with 2G of RAM and 2 933MHz PIII and NetGear 2Gbit NICs
>  > I achieve about 2500 SpecWeb99 connections, with both X15 and
>  > TUX (actually X15 is sligtly faster, some 20 connections more... ;)
>
> What is the CPU utilization like in X15 vs. TUX during
> these runs?
>
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

