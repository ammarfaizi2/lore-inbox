Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTGAM6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 08:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTGAM6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 08:58:38 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51394 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262316AbTGAM6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 08:58:37 -0400
Message-Id: <200307011312.h61DC6F2002208@eeyore.valparaiso.cl>
To: Samium Gromoff <deepfire@ibe.miee.ru>
cc: linux-kernel@vger.kernel.org, gcc-bugs@gcc.gnu.org
Subject: Re: [GCC] gcc vs. indentation 
In-Reply-To: Message from Samium Gromoff <deepfire@ibe.miee.ru> 
   of "Mon, 30 Jun 2003 09:20:15 +0400." <20030630092015.49dd6969.deepfire@ibe.miee.ru> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Tue, 01 Jul 2003 09:12:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff <deepfire@ibe.miee.ru> said:

[...]

> 	Surprisingly enough i`ve realised soon that indeed some indentation changes
>  give gcc a reason to produce different code.

[...]

> --- ./origDAC960.o.d    2003-06-29 21:02:55.000000000 +0400
> +++ ./newDAC960.o.d     2003-06-29 22:13:46.000000000 +0400
> -    52ae:      7d 0d                   jge    52bd <DAC960_V1_ProcessCompletedCommand+0x7d>
> +    52ae:      7c 0d                   jl     52bd <DAC960_V1_ProcessCompletedCommand+0x7d>

[...]

> -    542b:      8f 0d 27 00 00 00       popl   0x27
> +    542b:      8e 0d 27 00 00 00       movl   0x27,%cs

[...]

> -    6ba8:      bc 11 27 00 00          mov    $0x2711,%esp
> +    6ba8:      bb 11 27 00 00          mov    $0x2711,%ebx

This looks like 1-bit errors to my eye...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
