Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316167AbSEJXe2>; Fri, 10 May 2002 19:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316168AbSEJXe1>; Fri, 10 May 2002 19:34:27 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:33241 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316167AbSEJXe0>;
	Fri, 10 May 2002 19:34:26 -0400
Date: Fri, 10 May 2002 16:34:24 -0700
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: jt@hpl.hp.com, Jeff Garzik <jgarzik@mandrakesoft.com>,
        irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] : ir253_smc_msg.diff
Message-ID: <20020510163424.A14554@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020510154108.B14407@bougret.hpl.hp.com> <3CDC4648.207@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 12:14:32AM +0200, Martin Dalecki wrote:
> Uz.ytkownik Jean Tourrilhes napisa?:

	Qu'est ce que ca veux dire ?

> Should read:
>    +     IRDA_DEBUG(0, "%s (), releasin.... ", __FUNCTION__,
> 
> due to the fact that newer versions of GCC will be more standard
> aheren. Well the motivation is to coalesce all the places
> where __FUNCTION__ is used in to one instance of the corresponding
> string only.

	Don't mention it. The IrDA code is full of it :-( If you want
to fix that, be my guest...

	Jean
