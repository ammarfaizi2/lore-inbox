Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRKVMbV>; Thu, 22 Nov 2001 07:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278042AbRKVMbL>; Thu, 22 Nov 2001 07:31:11 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:22545 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S277949AbRKVMa5>; Thu, 22 Nov 2001 07:30:57 -0500
Message-Id: <200111221230.fAMCU6QJ007258@pincoya.inf.utfsm.cl>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove needless BKL from release functions 
In-Reply-To: Message from Christoph Hellwig <hch@ns.caldera.de> 
   of "Thu, 22 Nov 2001 13:11:50 BST." <200111221211.fAMCBoc15728@ns.caldera.de> 
Date: Thu, 22 Nov 2001 09:30:06 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@ns.caldera.de> said:
> In article <01112211121601.00690@argo> you wrote:
> > At least some of the removals in the input tree are probably wrong. You
> > are introducing a race with deregistering of input devices.

> Nope, it's fine to remove it.  Input is racy all over the place and the list
> are modified somewhere else without any locking anyways.

"It is broken anyway, breaking it some more makes no difference"!?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
