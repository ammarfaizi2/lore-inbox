Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbTCQVdD>; Mon, 17 Mar 2003 16:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbTCQVdC>; Mon, 17 Mar 2003 16:33:02 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:7691 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261916AbTCQVdB>; Mon, 17 Mar 2003 16:33:01 -0500
Message-Id: <200303172143.h2HLhLql010853@pincoya.inf.utfsm.cl>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-reply-to: Your message of "Mon, 17 Mar 2003 08:56:54 +0200."
             <200303170700.h2H70Qu18002@Port.imtp.ilyichevsk.odessa.ua> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 17 Mar 2003 17:43:21 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:
> On 15 March 2003 20:34, Horst von Brand wrote:
> > Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:

[...]

> > > Why not? Disassemble from, say, EIP-16 and check whether you
> > > have an instruction starting exactly at EIP. If no, repeat from
> > > EIP-15, -14... You are guaranteed to succeed at EIP-0  ;)

> > But your previous success (if any) doesn't mean anything, and might
> > even screw up the decoding after EIP

> How come? If I started to decode at EIP-n and got a sequence of
> instructions at EIP-n, EIP-n+k1, EIP-n+k2, EIP-n+k3..., EIP,
> instructions prior to EIP can be wrong. Instruction at EIP
> and all subsequent ones ought to be right.

Iff you exactly hit EIP that way (sure, should check). But wrong previous
instructions _will_ confuse people or start them on all kind of wild goose
chases. Too much work for a dubious gain.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
