Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132741AbRDQQFC>; Tue, 17 Apr 2001 12:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132737AbRDQQEv>; Tue, 17 Apr 2001 12:04:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32527 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132740AbRDQQES>; Tue, 17 Apr 2001 12:04:18 -0400
Subject: Re: ARP responses broken!
To: gandalf@wlug.westbo.se (Martin Josefsson)
Date: Tue, 17 Apr 2001 17:05:16 +0100 (BST)
Cc: ak@suse.de (Andi Kleen), ehw@lanl.gov (Eric Weigle),
        sampsa@netsonic.fi (Sampsa Ranta), linux-net@vger.kernel.org,
        linux-kernel@vger.kernel.org, zebra@zebra.org
In-Reply-To: <Pine.LNX.4.21.0104171703250.9099-100000@tux.rsn.bth.se> from "Martin Josefsson" at Apr 17, 2001 05:07:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pXyi-0002d5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was asking because I had this problem before (router with two cards
> against one physical subnet) and arpwatch complained that the router kept
> switching MACaddresses all the time.

That sounds like a bug in arpwatch. A box can have multiple mac addresses. Its
probably a tricky one to handle but arpwatch I guess should spot and cope with
repeated transitions between the same set of addresses as one warning


