Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSHRR1x>; Sun, 18 Aug 2002 13:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSHRR1x>; Sun, 18 Aug 2002 13:27:53 -0400
Received: from mail.coastside.net ([207.213.212.6]:54730 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S315437AbSHRR1w>; Sun, 18 Aug 2002 13:27:52 -0400
Mime-Version: 1.0
Message-Id: <p05111a29b985874acb4f@[207.213.214.37]>
In-Reply-To: <1029666605.15858.9.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208172019130.1537-100000@home.transmeta.com>
 <1029666605.15858.9.camel@irongate.swansea.linux.org.uk>
Date: Sun, 18 Aug 2002 10:31:44 -0700
To: linux-kernel <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:30 AM +0100 8/18/02, Alan Cox wrote:
>Its probably true there are low bits of randomness available from such
>sources providing we know the machine has a tsc, unless the I/O APIC is
>clocked at a divider of the processor clock in which case our current
>behaviour is probably much saner.

The clock spec for the APIC bus makes it very convenient to clock it 
at 16.66_ MHz, 1/2 (or some other submultiple) of the PCI clock, 
which of course would be highly correlated with the low bits of TSC.
-- 
/Jonathan Lundell.
