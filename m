Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSIDXvI>; Wed, 4 Sep 2002 19:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSIDXvI>; Wed, 4 Sep 2002 19:51:08 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:17145 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316542AbSIDXvD>;
	Wed, 4 Sep 2002 19:51:03 -0400
Date: Wed, 4 Sep 2002 16:55:37 -0700
To: Robert Love <rml@tech9.net>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Irq handler reentrancy ?
Message-ID: <20020904235537.GG21592@bougret.hpl.hp.com>
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

	Definitely cured my problems. Thanks !

	Jean
