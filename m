Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbQKFRIE>; Mon, 6 Nov 2000 12:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQKFRHy>; Mon, 6 Nov 2000 12:07:54 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:24306 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129523AbQKFRHg>;
	Mon, 6 Nov 2000 12:07:36 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl> 
In-Reply-To: <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl> 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 17:06:46 +0000
Message-ID: <6590.973530406@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vonbrand@inf.utfsm.cl said:
>  No funny "persistent data" mechanisms or screwups when the worker
> gets removed and reinserted. In many cases the data module could be
> shared among several others, in other cases it would have to be able
> lo load several times or manage several incarnations of its payload. 

The reason I brought this up now is because Keith's new 
inter_module_register stuff could easily be used to provide this 
functionality _without_ the extra module remaining loaded.


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
