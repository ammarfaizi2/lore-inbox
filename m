Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130428AbQKGB1v>; Mon, 6 Nov 2000 20:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKGB1W>; Mon, 6 Nov 2000 20:27:22 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:11015 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129307AbQKGB1M>;
	Mon, 6 Nov 2000 20:27:12 -0500
Message-Id: <200011062357.eA6NvNm05106@sleipnir.valparaiso.cl>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Mon, 06 Nov 2000 17:06:46 -0000." <6590.973530406@redhat.com> 
Date: Mon, 06 Nov 2000 20:57:23 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> said:
> vonbrand@inf.utfsm.cl said:
> >  No funny "persistent data" mechanisms or screwups when the worker
> > gets removed and reinserted. In many cases the data module could be
> > shared among several others, in other cases it would have to be able
> > lo load several times or manage several incarnations of its payload. 

> The reason I brought this up now is because Keith's new 
> inter_module_register stuff could easily be used to provide this 
> functionality _without_ the extra module remaining loaded.

AFAIU, this is a acknowledged wart, to be added if there is no sane way out.
Better just loose it before it gets into the kernel, no?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
