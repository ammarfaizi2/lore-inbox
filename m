Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130284AbRBMXPn>; Tue, 13 Feb 2001 18:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRBMXPe>; Tue, 13 Feb 2001 18:15:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34572 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130284AbRBMXP2>; Tue, 13 Feb 2001 18:15:28 -0500
Subject: Re: Multicast on loopback?
To: egb@erikburrows.com (Erik G. Burrows)
Date: Tue, 13 Feb 2001 23:12:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102131445030.11824-100000@centrum.jedi-group.com> from "Erik G. Burrows" at Feb 13, 2001 03:03:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SocF-0003Df-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> locally over the loopback interface. This does not work without adding a 
> bogus route statement to get the kernel to hand up the packets from
> loopback to my waiting application.

The multicast ABI includes the ability to toggle loopback of multicast
datagrams. Use the socket options instead

