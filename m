Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUEaVL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUEaVL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUEaVL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 17:11:57 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:21425 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264791AbUEaVL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 17:11:56 -0400
Message-Id: <200405312111.i4VLBYKg006516@eeyore.valparaiso.cl>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module? 
In-Reply-To: Message from Manfred Spraul <manfred@colorfullife.com> 
   of "Mon, 31 May 2004 22:38:30 +0200." <40BB97C6.9020109@colorfullife.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 31 May 2004 17:11:34 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> said:
> Horst von Brand wrote:
> >Trascendental functions are _not_ computed by series in practice, rational
> >approximations (polinomial / polinomial) are used instead. Or interpolate
> >in a smallish table.

> Is that really faster on modern cpus? The multiplier is fully pipelined 
> and a division takes 25-40 cycles.

You need smallish polinomials for double precision, via series it would
take you a lot more terms (and then you get trouble from rounding etc).

No, numerical computation is not my main interest. I might be wrong here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
