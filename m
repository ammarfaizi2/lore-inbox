Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbTJJWEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbTJJWEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:04:11 -0400
Received: from aneto.able.es ([212.97.163.22]:64473 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263148AbTJJWEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:04:08 -0400
Date: Sat, 11 Oct 2003 00:04:05 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI64 bus vanished in 2.4.23-pre6
Message-ID: <20031010220405.GA2099@werewolf.able.es>
References: <Pine.LNX.4.44.0310101524200.1370-200000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0310101524200.1370-200000@logos.cnet>; from marcelo.tosatti@cyclades.com on Fri, Oct 10, 2003 at 20:28:20 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.10, Marcelo Tosatti wrote:
> 
> 
> On Tue, 7 Oct 2003, J.A. Magallon wrote:
> 
> > Hi all...
> > 
> > With 2.4.23-pre6, my e1000 cards did not work. I was thinking it was a driver
> > problem, but the I realized that they are not even listed in lspci.
> >
> > <moilanen:austin.ibm.com>:
> >   o Workaround PPC64 PCI scan issue
> 
> This has a high chance of being the problem.
> 
> Attached patch for you to revert (-R) and retry is attached, please. :)
> 

Thanks, I can't try it until monday (I need to be in front of the box to
see the node messages ;)).

Will report about the results.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre6-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
