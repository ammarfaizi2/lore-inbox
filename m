Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310491AbSCGTtf>; Thu, 7 Mar 2002 14:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310493AbSCGTt0>; Thu, 7 Mar 2002 14:49:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8834 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310491AbSCGTtV>; Thu, 7 Mar 2002 14:49:21 -0500
Date: Thu, 7 Mar 2002 14:48:33 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Julian Anastasov <ja@ssi.bg>
cc: Luca Montecchiani <luca.montecchiani@teamfab.it>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] Linux 2.2.21pre[23]
In-Reply-To: <Pine.LNX.4.44.0203072136230.20933-100000@l>
Message-ID: <Pine.LNX.3.95.1020307144538.22025B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Julian Anastasov wrote:

> 
> 	Hello,
> 
> Luca Montecchiani wrote:
> 
> > oops
> > ----
> > CPU serial number disabled.
> > Unable to handle kernel paging request at virtual address 756e654f
> 
> http://marc.theaimsgroup.com/?t=99545372300004&r=1&w=2
> 
> Regards

You are executing (possibly) text! Looks like an _asm_() procedure is
trashing a register that it shouldn't. Work-around: Don't disable the
serial number until the code is fixed.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

