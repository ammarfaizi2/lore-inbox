Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbQLAXTY>; Fri, 1 Dec 2000 18:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129891AbQLAXTN>; Fri, 1 Dec 2000 18:19:13 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:21508 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129830AbQLAXTD>; Fri, 1 Dec 2000 18:19:03 -0500
Date: Fri, 1 Dec 2000 16:48:13 -0600
To: Roger Crandell <rwc@lanl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiprocessor kernel problem
Message-ID: <20001201164813.C25464@wire.cadcamlab.org>
In-Reply-To: <3A27D4D6.4DA47346@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A27D4D6.4DA47346@lanl.gov>; from rwc@lanl.gov on Fri, Dec 01, 2000 at 09:41:58AM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Roger Crandell]
> When I boot the machine with the multiprocessor kernel and run
> iptables, the kernel dumps several pages of hex and the final two
> lines of output are:
> 
> Killing interrupt handler
> scheduling in interrupt

Look through the "several pages of hex" for any number in square +
angle brackets i.e. [<xxxxxxxx>] (particularly the EIP and the stack),
and write these down.  Then run these numbers through ksymoops.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
