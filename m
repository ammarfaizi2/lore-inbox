Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSIDW21>; Wed, 4 Sep 2002 18:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSIDW21>; Wed, 4 Sep 2002 18:28:27 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:60914 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315721AbSIDW20>;
	Wed, 4 Sep 2002 18:28:26 -0400
Date: Wed, 4 Sep 2002 15:32:47 -0700
To: Robert Love <rml@tech9.net>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Irq handler reentrancy ?
Message-ID: <20020904223247.GC21494@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020904221853.GB21494@bougret.hpl.hp.com> <1031178569.24333.3685.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031178569.24333.3685.camel@phantasy>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 06:29:28PM -0400, Robert Love wrote:
> On Wed, 2002-09-04 at 18:18, Jean Tourrilhes wrote:
> 
> > 	Just a quick question : can an interrupt handler be preempted
> > or reenter itself ?
> 
> It is not supposed to.
> 
> There is a bug in 2.5, with a fix from Linus currently in bitkeeper.  I
> have attached the patch.
> 
> 	Robert Love

	You saved my life ! I was beggining to get crazy.
	I just need to check the patch ;-)

	Jean
