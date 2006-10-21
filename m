Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWJUAOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWJUAOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWJUAOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:14:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:35215 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161154AbWJUAOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:14:21 -0400
Message-Id: <200610210014.k9L0E3pr005019@laptop13.inf.utfsm.cl>
To: Jens Axboe <jens.axboe@oracle.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fs/Kconfig question regarding CONFIG_BLOCK 
In-Reply-To: Message from Jens Axboe <jens.axboe@oracle.com> 
   of "Wed, 18 Oct 2006 09:09:22 +0200." <20061018070922.GB24452@kernel.dk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Fri, 20 Oct 2006 21:14:03 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 20 Oct 2006 21:14:10 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> wrote:
> On Tue, Oct 17 2006, Jan Engelhardt wrote:
> > >> Never mind, I see that some filesystems have 'depends on BLOCK' instead 
> > >> of being wrapped into if BLOCK. Not really consistent but whatever.
> > >
> > >Feel free to send in patches that make things more consistent.
> > 
> > How would you like things? if BLOCK or depends on BLOCK?
> 
> Well, if you can hide an entire block with if BLOCK, then that would be
> preferred. Otherwise depends on BLOCK.
> 
> > Does menuconfig/oldconfig/etc. parse the whole config structure faster 
> > it it done either way?
> 
> I'd be surprised if if BLOCK wasn't faster over, say, 10 depends on
> BLOCK.

I'd be /very/ surprised if anybody even noticed...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
