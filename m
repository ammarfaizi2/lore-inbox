Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268403AbRGXR5W>; Tue, 24 Jul 2001 13:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268406AbRGXR5M>; Tue, 24 Jul 2001 13:57:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63497 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268400AbRGXR4z>; Tue, 24 Jul 2001 13:56:55 -0400
Subject: Re: Externally transparent routing
To: jordiv@steva.nl (Jordi Verwer)
Date: Tue, 24 Jul 2001 18:56:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <no.id> from "Jordi Verwer" at Jul 24, 2000 10:45:02 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15P6QK-0000aq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> To prevent my NAT-box from showing up on traceroutes I'd like to let it
> route without decreasing the TTL. I was told that proxy arp also archieves

And what happens if you get a routing loop ?

A NAT box really does need to drop the TTL. Nothing stops you giving it a
more bizarre name, or indeed you can do what a few folks have found
excruciatingly funny to do to tracerouters which is to spoof totally bogus
icmp unreachables so they see crazy paths
