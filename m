Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbRFYV0G>; Mon, 25 Jun 2001 17:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRFYVZ4>; Mon, 25 Jun 2001 17:25:56 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:59152 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261562AbRFYVZt>; Mon, 25 Jun 2001 17:25:49 -0400
Message-Id: <200106252125.f5PLPfmL012650@pincoya.inf.utfsm.cl>
To: Alan Shutko <ats@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules 
In-Reply-To: Message from Alan Shutko <ats@acm.org> 
   of "Mon, 25 Jun 2001 09:59:32 -0400." <87g0cobrgz.fsf@wesley.springies.com> 
Date: Mon, 25 Jun 2001 17:25:40 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Shutko <ats@acm.org> said:
> One more tidbit: ISO/IEC 9899:1990 3.14
> 
>   3.14 object: A region of data storage in the execution environment,
>     the contents of which can represent values.  Except for
>     bit-fields, objects are composed of contiguous sequences of one or
>     more bytes, the number, order and encoding of which are either
>     explicitely specified or implementation-defined.
> 
> This would specifically prohibit separating any part of a structure
> from the rest.

It just prohibits separating bytes, not subobjects. I.e., everything can be
handled as an array of bytes (of the appropiate length, as given by
sizeof())
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
