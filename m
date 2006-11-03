Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753422AbWKCTO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbWKCTO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbWKCTO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:14:57 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32207 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753422AbWKCTO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:14:56 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Gabriel C <nix.or.die@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: New filesystem for Linux
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
	<454A71EB.4000201@googlemail.com>
	<Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
	<20061102174149.3578062d.akpm@osdl.org>
	<20061103171443.GA16912@flower.upol.cz>
	<1162580419.12810.28.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 03 Nov 2006 20:14:51 +0100
In-Reply-To: <1162580419.12810.28.camel@localhost.localdomain>
Message-ID: <p73r6wkjqac.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Ar Gwe, 2006-11-03 am 17:14 +0000, ysgrifennodd Oleg Verych:
> > In gmane.linux.kernel, you wrote:
> > []
> > > From: Andrew Morton <akpm@osdl.org>
> > >
> > > As Mikulas points out, (1 << anything) won't be evaluating to zero.
> > 
> > How about integer overflow ?
> 
> That is undefined in C and for some cases will not produce zero but roll
> anything%32 bits and the like. If anyone is relying on 1 << foo becoming
> zero they need fixing

Vaxen will throw an exception.

-Andi
