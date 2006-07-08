Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWGHQIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWGHQIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWGHQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:08:20 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8644 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964883AbWGHQIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:08:20 -0400
Message-Id: <200607081333.k68DXM8R004756@laptop11.inf.utfsm.cl>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: David Miller <davem@davemloft.net>, vonbrand@inf.utfsm.cl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 on SPARC64 compile fails 
In-Reply-To: Message from "Randy.Dunlap" <rdunlap@xenotime.net> 
   of "Wed, 05 Jul 2006 13:15:39 MST." <20060705131539.ba3275d8.rdunlap@xenotime.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sat, 08 Jul 2006 09:33:22 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 08 Jul 2006 12:08:01 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Wed, 05 Jul 2006 11:39:11 -0700 (PDT) David Miller wrote:
> > From: Horst von Brand <vonbrand@inf.utfsm.cl>

[...]

> > > Looking at the relevant file, it seems the offending functions are
> > > for PCI only (and my SparcStation Ultra 1 sure doesn't have any PCI
> > > in it, so this is disabled in the configuration). Maybe the #endif is
> > > too early?

> > Yes, I'm still thinking how to fix this.

> Do you mean a generalized arch-independent fix?
> 
> > Turn CONFIG_PCI on as a workaround for now.

FWIW, 2.6.18-rc1 works fine (it's what I'm running now)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
