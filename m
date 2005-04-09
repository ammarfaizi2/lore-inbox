Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVDIKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVDIKOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVDIKOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 06:14:44 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:49328 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261329AbVDIKOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 06:14:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TZMoxJS5LPLoXXeKWM4hZ+0gfUnfnG2H8vATmXhCTJ72f/kf4mZYxm6jxGQr4BldbKgPSUtL/gGe8l+5vZMgyqkXuOX8QiR4GLnQ30sYqJeFHnRwe/DGLuhdlTQ34ejZ3yyObXHBr3KvNibB7Icx1DX7FgxdcAzGI5wUF3UOdk0=
Message-ID: <aec7e5c305040903142cf51f50@mail.gmail.com>
Date: Sat, 9 Apr 2005 12:14:42 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: rddunlap@osdl.org, linux-os@analogic.com, roland@topspin.com,
       asterixthegaul@gmail.com, damm@opensource.se,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050409100702.GA6148@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <aec7e5c305040711535bbe07d3@mail.gmail.com>
	 <E1DK4zA-0005rr-00@gondolin.me.apana.org.au>
	 <aec7e5c3050409024365d724dd@mail.gmail.com>
	 <20050409094814.GA5953@gondor.apana.org.au>
	 <aec7e5c30504090303790ff7a7@mail.gmail.com>
	 <20050409100702.GA6148@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 9, 2005 12:07 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Sat, Apr 09, 2005 at 12:03:45PM +0200, Magnus Damm wrote:
> >
> > > Perhaps they should start using initramfs then.
> >
> > But how does that help me? I still want to be able to pass a list of
> > unwanted modules on the kernel command line. Using initramfs and
> > modules is fine, although I would prefer being able to unload built-in
> > modules instead - but that is another story. Your suggestion just
> > pushes the problem to user space. I think the best alternative would
> 
> Well you know what they say:
> 
> If it can be done in user space, then do it in user space.
> 
> Once the drivers are put on the initramfs it is trivial to add code that
> disables them based on boot-time options.

I agree. And if I understand your opinion correctly you believe that
kernels with built-in modules should not have the feature that my
patch provides, right?

I think it would be a nice feature regardless of initramfs or not.

Thanks for your input!

/ magnus
