Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVJLMVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVJLMVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 08:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVJLMVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 08:21:34 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:2195 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932412AbVJLMVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 08:21:33 -0400
Message-Id: <200510120108.j9C18GfV005006@laptop11.inf.utfsm.cl>
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Instantiating my own random number generator 
In-Reply-To: Message from Roberto Jung Drebes <drebes@inf.ufrgs.br> 
   of "Tue, 11 Oct 2005 17:46:18 -0300." <E90C20D8-AC5D-4E9E-A477-48164FA0E7EE@inf.ufrgs.br> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 11 Oct 2005 22:08:16 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 12 Oct 2005 09:21:28 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Jung Drebes <drebes@inf.ufrgs.br> wrote:
> I have a kernel module which asks for random numbers using
> get_random_bytes().
> 
> Is there a way I can set this number generator my own seed value, so
> that I can replay experiments I perform with my module? If I set a
> seed for the whole system, it would affect other kernel tasks
> obtaining random numbers through get_random_bytes(), so I guess that
> is not a good solution.

If it is for experiments, just call MY_get_random_bytes() instead, and
define that one as you see fit. This will only work if it is called
directly, but then again...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

