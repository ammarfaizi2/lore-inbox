Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbSLKAT4>; Tue, 10 Dec 2002 19:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbSLKAT4>; Tue, 10 Dec 2002 19:19:56 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:28609
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266868AbSLKATz>; Tue, 10 Dec 2002 19:19:55 -0500
Subject: Re: 2.5.51 don't compil with dvb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: greg@ulima.unil.ch,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-dvb@linuxtv.org
In-Reply-To: <20021211105343.4385029a.rusty@rustcorp.com.au>
References: <20021210150748.GB20411@ulima.unil.ch>
	<1039536315.14175.2.camel@irongate.swansea.linux.org.uk> 
	<20021211105343.4385029a.rusty@rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 01:04:40 +0000
Message-Id: <1039568680.15174.103.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 23:53, Rusty Russell wrote:
> On 10 Dec 2002 16:05:15 +0000
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Tue, 2002-12-10 at 15:07, Gregoire Favre wrote:
> > > drivers/built-in.o(.text+0x38655): In function `try_attach_device':
> > > : undefined reference to `MOD_CAN_QUERY'
> > > make: *** [vmlinux] Error 1
> > > 
> > 
> > Modules are still very broken in 2.5.51, its best to compile a system
> > which doesn't use modules or stay at an older kernel
> 
> That may be true, but in this case, it's the only occurrance of MOD_CAN_QUERY
> outside the archs which haven't been updated to the new module loader yet,
> and it's a very odd thing to do.
> 
> I assume the author meant this:

That looks right to me yes

