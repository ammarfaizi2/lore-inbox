Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWJ0Rkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWJ0Rkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 13:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWJ0Rkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 13:40:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30102 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751316AbWJ0Rka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 13:40:30 -0400
Message-Id: <200610271739.k9RHdvXa024984@laptop13.inf.utfsm.cl>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
cc: linux-kernel@vger.kernel.org, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: removing drivers and ISA support? [Was: Char: correct pci_get_device 
In-Reply-To: Message from "Kilau, Scott" <Scott_Kilau@digi.com> 
   of "Fri, 27 Oct 2006 10:01:00 CDT." <335DD0B75189FB428E5C32680089FB9F804012@mtk-sms-mail01.digi.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Fri, 27 Oct 2006 14:39:57 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 27 Oct 2006 14:39:57 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kilau, Scott <Scott_Kilau@digi.com> wrote:
> Alan Cox:
> > I think some of the drivers like epca we should seriously consider
> > dropping and seeing if there is any complaint, my guess will be not.
> 
> You sure won't have any compliants from Digi International about removing
> the epca driver from the kernel tree.

> That driver is *ancient* and I suspect no one actually uses it.
> (I am not sure its even useable in the current form in the kernel tree)
> 
> We (Digi) have a much newer "PCI-only, rewritten for 2.6.x" open source
> version of the driver called "dgap" that all our customers use now
> instead.

Have you proposed it for inclusion in the official tree? Many distros today
don't ship drivers that aren't in the oficial tree, so you are needlessly
limiting your customer base (plus adding hassle for them, plus you have to
track kernel changes yourself). Not a winning proposition, IMHO.

Thanks for your support of Linux!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
