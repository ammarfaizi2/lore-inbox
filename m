Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282608AbRKZWYY>; Mon, 26 Nov 2001 17:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282609AbRKZWYO>; Mon, 26 Nov 2001 17:24:14 -0500
Received: from air-1.osdl.org ([65.201.151.5]:35845 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S282608AbRKZWYH>;
	Mon, 26 Nov 2001 17:24:07 -0500
Message-ID: <3C02C05D.FA937E18@osdl.org>
Date: Mon, 26 Nov 2001 14:21:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Achim =?iso-8859-1?Q?Kr=FCmmel?= <akruemmel@dohle.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel I860
In-Reply-To: <3BFD0F19.86D23BEB@dohle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Achim Krümmel wrote:
> 
> Hi,
> 
> I have to setup a fast Linux Server for a database application.
> I would like to use a Mainboard for 2 Pentium4 CPUs for this.
> I found such a board with a Intel I860 chip. Is this chip
> supported by the current Kernel v2.4.14 or will I get problems
> with this board and Linux?

I haven't seen any other replies, so here goes.

You should have no problem using the 860 chipset AFAIK
[but I don't have such a system :(  ].

There are still some issues with interrupt balancing on SMP
P4 systems.  Last I heard, all interrupts will be routed
to one CPU instead of [mostly] balanced between them
(until this is fixed/patched).

HTH.
~Randy
