Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWFIXlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWFIXlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWFIXlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:41:23 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60105 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932588AbWFIXlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:41:23 -0400
Message-Id: <200606092341.k59Nf6RJ003396@laptop11.inf.utfsm.cl>
To: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
cc: Linux e-posta listesi <linux-kernel@vger.kernel.org>
Subject: Re: Discovering select(2) parameters from driver's poll method 
In-Reply-To: Message from Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr> 
   of "Fri, 09 Jun 2006 16:34:12 +0300." <20060609133300.7528F490168@uekae.uekae.gov.tr> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Fri, 09 Jun 2006 19:41:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 09 Jun 2006 19:41:11 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr> wrote:
> I agree you, but your assumption is correct for a generic device, not
> mine.  The purpose of my driver is slightly different and is not to
> realize user space request, like other drivers in Linux kernel do.  My
> goal is to forward the userspace system call to a remote computer, and
> therefore I need information about these variables in order to call them
> correctly via an user space application on the remote host.

In that case, this is /not/ a device... The "If it waddles like a duck, and
quacks like a duck, it is (probably) a duck" can be turned around...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
