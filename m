Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbVGNULy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbVGNULy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVGNUJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:09:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58022 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263126AbVGNUH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:07:27 -0400
Message-Id: <200507142007.j6EK7Iax030363@laptop11.inf.utfsm.cl>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
cc: Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: eepro100/e100 broken in 2.6.13-rc3 
In-Reply-To: Message from Jesse Brandeburg <jesse.brandeburg@gmail.com> 
   of "Wed, 13 Jul 2005 23:28:15 MST." <4807377b05071323286963bf3a@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 14 Jul 2005 16:07:18 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 14 Jul 2005 16:07:19 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:
> On 7/13/05, Mikhail Kshevetskiy <kl@laska.dorms.spbu.ru> wrote:
> > symptom
> > =======
> > modprobe e100
> > ifconfig eth0 <ip> netmask <netmask>
> > 
> > result:
> > =======
> > SIOCADDRT: Network is unreachable
> > 
> > There were no such error in 2.6.13-rc2

> odd, both e100 and eepro100 are broken?  This might indicate something
> wierd with the pci layer.  Don't know what might cause the Network is
> unreachable...

It works fine here... latest .git from yesterday.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
