Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAKLG6>; Thu, 11 Jan 2001 06:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAKLGt>; Thu, 11 Jan 2001 06:06:49 -0500
Received: from jalon.able.es ([212.97.163.2]:55009 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131487AbRAKLGb>;
	Thu, 11 Jan 2001 06:06:31 -0500
Date: Thu, 11 Jan 2001 12:06:20 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Grahame Jordan <gbj@ob1.theforce.com.au>
Cc: linux-kernel@vger.kernel.org, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Subject: Re: 2.4.0 will not boot for me
Message-ID: <20010111120620.C25299@werewolf.able.es>
In-Reply-To: <20010110150128.E13334@arthur.ubicom.tudelft.nl> <Pine.LNX.4.30.0101112153400.8223-200000@ob1.theforce.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.30.0101112153400.8223-200000@ob1.theforce.com.au>; from gbj@ob1.theforce.com.au on Thu, Jan 11, 2001 at 11:57:30 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.11 Grahame Jordan wrote:
> 
> > On Tue, Jan 09, 2001 at 07:08:58PM +1100, Grahame Jordan wrote:
> > > I have a Tyan Thunder ATX S1696DULA Motherboard with 2 x PII266, humble
                                                               ^^^^^^
Perhaps this ???:

> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set      <========= This is what you have
> CONFIG_M686FXSR=y             <========= You're compiling for PIII
> # CONFIG_MPENTIUM4 is not set


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac5 #1 SMP Wed Jan 10 23:36:11 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
