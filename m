Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSGSHMZ>; Fri, 19 Jul 2002 03:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318439AbSGSHMZ>; Fri, 19 Jul 2002 03:12:25 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:15388 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S316161AbSGSHMY>; Fri, 19 Jul 2002 03:12:24 -0400
Date: Fri, 19 Jul 2002 08:17:22 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027022323.8154.38.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0207190755550.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2002, Alan Cox wrote:
> Adjusting the percentages to have a root only zone is doable. It helps
> in some conceivable cases but not all.

For 2.2 kernels I've found 5 MB reserved from swap until it was needed
was enough to ssh to the box and fix whatever was going on (whatever:
real world cases like slashdot effects, exploits from packetstorm and
other own made testcases that heavily overcommited memory). Nevertheless
the amount reserved was controllable via /proc.

And I do know it doesn't solve all cases but covering 99% of the real
world issues isn't a bad start at all, imho.

	Szaka

