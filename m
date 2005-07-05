Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVGES61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVGES61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVGES61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:58:27 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7821 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261948AbVGES6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:58:24 -0400
Message-Id: <200507051858.j65IwKlv005612@laptop11.inf.utfsm.cl>
To: Xin Zhao <uszhaoxin@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why cannot I do "insmod nfsd.ko" directly? 
In-Reply-To: Message from Xin Zhao <uszhaoxin@gmail.com> 
   of "Tue, 05 Jul 2005 14:23:39 -0400." <4ae3c140507051123758bb61e@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 05 Jul 2005 14:58:20 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 05 Jul 2005 14:58:21 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao <uszhaoxin@gmail.com> wrote:
> I tried to do "insmod nfsd.ko", but always got the error message
> "insmod: error inserting 'nfsd.ko': -1 Unknown symbol in module"

Use modprobe(8), it knows about module dependencies and what to load.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
