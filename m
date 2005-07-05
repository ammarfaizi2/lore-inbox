Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVGENtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVGENtn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVGENtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:49:42 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:23957 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261840AbVGENrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:47:52 -0400
Message-Id: <200507051346.j65DkJdS003691@laptop11.inf.utfsm.cl>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Adrian Bunk <bunk@stusta.de>, Alexander Nyberg <alexn@telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS 
In-Reply-To: Message from Denis Vlasenko <vda@ilport.com.ua> 
   of "Tue, 05 Jul 2005 09:14:30 +0300." <200507050914.30701.vda@ilport.com.ua> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 05 Jul 2005 09:46:19 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 05 Jul 2005 09:46:20 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> wrote:
> > > > > NB: gcc 3.4.3 can use excessive stack in degenerate cases, so please
> > > > > include gcc version in your reports.
> > > > 
> > > > But this can't occur in the kernel.
> > > 
> > > It can. I saw the OOPS myself.
> > > One of the functions in crypto/wp512.c was compiled with 3k+ stack usage.
> > 
> > Strange that "make checkstack" didn't show this.
> 
> It happens with certain gcc versions only.

Which ones, exactly? If they break this way, a workaround (or forbidding
them) would be the way to go...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
