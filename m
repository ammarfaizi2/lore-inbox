Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318447AbSH1BTJ>; Tue, 27 Aug 2002 21:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSH1BTJ>; Tue, 27 Aug 2002 21:19:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3845 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318447AbSH1BTI>; Tue, 27 Aug 2002 21:19:08 -0400
Date: Tue, 27 Aug 2002 18:29:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
In-Reply-To: <20020828045802.A31036@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0208271828080.1287-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Ivan Kokshaysky wrote:
>
> I would even go further and add a "quirks" field to the struct
> pci_dev (probably 16 bits would be enough).

Why add a bitfield, and not just add single bitmembers?

Other than that, I certainly wouldn't mind. 

		Linus

