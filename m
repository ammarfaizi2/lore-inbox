Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRDTTo0>; Fri, 20 Apr 2001 15:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135996AbRDTToI>; Fri, 20 Apr 2001 15:44:08 -0400
Received: from chiara.elte.hu ([157.181.150.200]:19979 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131979AbRDTTnr>;
	Fri, 20 Apr 2001 15:43:47 -0400
Date: Fri, 20 Apr 2001 20:42:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: Zach Brown <zab@zabbo.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: numbers?
In-Reply-To: <3AE08F8E.643FDC63@chromium.com>
Message-ID: <Pine.LNX.4.30.0104202033160.2706-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Apr 2001, Fabio Riccardi wrote:

> X15 is the server I was referring to and as far as I can measure I get
> very much the same performance as TUX.
>
> On a Dell 4400 (933 MHz PIII, 2G of RAM, 5 9G disks) I get 2450
> connections/second.

(the unit is not "connections/second" but "connections")

> On a Dell PowerEdge 1550/1000 the published TUX 2 result is 2765.
>
> If you take into account the fact that the 1550 has a faster processor
> (1GHz) and a more modern bus architecture (Serverworks HE with memory
> interleaving and a triple PCI bus), the performance is roughly the
> same.

the system was IO-limited (given that a ~9 GB fileset was running on a 2
GB RAM system), so CPU speed has not a big impact. I'd say it makes no
sense to compare different systems.

> The static pages work fine, the dynamic module gets executed, but for
> some reason it fails to open the postlog file and to spawn the spec
> utility tasks at reset time.

the newest TUX code chroots into docroot, so you should either use "/" as
the docroot, or put /lib libraries into your docroot.

> I'll make an alpha release of X15 available for download by the end of
> next week, so people will be able to test it independently.

(will source code be available so we can see whether it's an apples to
apples thing?)

	Ingo

