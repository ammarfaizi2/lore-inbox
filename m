Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVDIJoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVDIJoD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 05:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVDIJoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 05:44:03 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:14758 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261206AbVDIJn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 05:43:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uNjArTGRL6B8qCkuC4gl7iLjfejdKyORUYL6GsKTw05pvptXbYt7USoLBfAWxewSqh0sKWDVwNlvkBngJf9gFn1WmoDSfQnb2792BoYuxHshtIpujqwOt2iSWewFU4TVwitsbWyZJD+OKIDbXwZZfAGtKTpCf/fyF/wozFsXhJ4=
Message-ID: <aec7e5c3050409024365d724dd@mail.gmail.com>
Date: Sat, 9 Apr 2005 11:43:59 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: rddunlap@osdl.org, linux-os@analogic.com, roland@topspin.com,
       asterixthegaul@gmail.com, damm@opensource.se,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DK4zA-0005rr-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <aec7e5c305040711535bbe07d3@mail.gmail.com>
	 <E1DK4zA-0005rr-00@gondolin.me.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 9, 2005 3:42 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Magnus Damm <magnus.damm@gmail.com> wrote:
> >
> > Say a kernel shipped with your favourite distribution crashes your
> > machine during boot-up - wouldn't it be nice to be able to just
> > disable the problematic module from the kernel command line instead of
> 
> Perhaps your favourite distribution could build that as a module to
> start with.

Right. Today distributions can boot from external usb-storage devices,
maybe even from firewire hardware as I am sure you know. I guess they
have support for a device built-in for a reason. I think most
distributions have as streamlined kernels as possible with much code
built as modules - but they would still need some code built-in in the
kernel to have a generic kernel that supports a lot of block devices.
So I think my patch still have a value.

In my case a firewire phy is broken - and, yes - I should fix my
hardware instead of moaning about it here...

Thanks,

/ magnus
