Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310295AbSDAHyY>; Mon, 1 Apr 2002 02:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSDAHyO>; Mon, 1 Apr 2002 02:54:14 -0500
Received: from NS.iNES.RO ([193.230.220.1]:63371 "EHLO Master.iNES.RO")
	by vger.kernel.org with ESMTP id <S310295AbSDAHyA>;
	Mon, 1 Apr 2002 02:54:00 -0500
Subject: Re: Number of loopback devices
From: Dumitru Ciobarcianu <cioby@lnx.ro>
To: Dale Amon <amon@vnl.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020401003015.GO4583@vnl.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-1) 
Date: 01 Apr 2002 10:52:22 +0300
Message-Id: <1017647543.1449.1.camel@LNX.iNES.RO>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is configurable.

options loop max_loop=n

in modules.conf, or if youre using it builtin

max_loop=n at kernel options.

//Cioby

On Lu, 2002-04-01 at 03:30, Dale Amon wrote:
> Loopbacks are so damned useful that I'm certain I'll
> soon run out of them, and I doubt I'm the only person
> in that position, particularly with some of the 
> improvements in the crypto patches making it possible
> to run an all crypto system.
> 
> I note that the number is set in loop.c
> 
> 	static int max_loop = 8;
> 
> and I wonder what the safe upper limit for this is, 
> and if there is some reason for not making it larger
> or perhaps making it a CONFIGurable item?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



