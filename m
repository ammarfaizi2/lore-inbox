Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280132AbRLBQP2>; Sun, 2 Dec 2001 11:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280133AbRLBQPT>; Sun, 2 Dec 2001 11:15:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11793 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280132AbRLBQPE>; Sun, 2 Dec 2001 11:15:04 -0500
Subject: Re: 2.4.16: TCP shutdown generating infinite ACK storm
To: jeremy@goop.org (Jeremy Fitzhardinge)
Date: Sun, 2 Dec 2001 16:23:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <1007290602.1892.2.camel@ixodes.goop.org> from "Jeremy Fitzhardinge" at Dec 02, 2001 02:56:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AZP3-0003lP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with packets.  It looks like Linux has got confused about sequence
> numbers (or maybe the other end is confused?).

Probably  it went through some crap load balancer on the way.

> I'm using 2.4.16 with no particularly special patches.  The gateway
> machine is another 2.4.16 box doing NAT with ipchains emulation.
> 
> Any other info needed?

You need to capture the entire misbehaving session at both ends to really
see what is going on and what is mangling it in the middle
