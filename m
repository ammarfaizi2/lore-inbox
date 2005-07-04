Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVGDBxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVGDBxV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 21:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVGDBxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 21:53:21 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:27792 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261378AbVGDBxN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 21:53:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YxGU0IeT3N1dxFBGYBw94Gt/em08cqE5o0PAs334CztdGvRirJuSIdWT57DI/RkaBLKe7V6FqMRSL5EQLOb47xQedz3q66Z3/TZxl/vEmj0W1YvlOcn3lPiudxIU1p3JIZGmYZmTSAIlzBQ0GTcF65a0LUV8pMJxHrAmlVSbn4M=
Message-ID: <98df96d30507031853328b16c@mail.gmail.com>
Date: Mon, 4 Jul 2005 10:53:13 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: i2o driver and OOM killer on 2.6.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98df96d3050628041362ea8d1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98df96d305062503281efa5f5a@mail.gmail.com>
	 <1119702614.3157.19.camel@laptopd505.fenrus.org>
	 <98df96d305062506477e32f447@mail.gmail.com>
	 <98df96d3050628041362ea8d1b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

I tried to reproduce OOM killer issues with i2o driver
on the following vanilla kernels.

2.6.12.1 OK (I could not get OOM)
2.6.11.6 OK
2.6.11.2 OK
2.6.10   OK
2.6.9    NG

So I guess there is some fix between 2.6.9 and 2.6.10

Regards,
  Hiro

On 6/28/05, Hiro Yoshioka <lkml.hyoshiok@gmail.com> wrote:
> On 6/25/05, Hiro Yoshioka <lkml.hyoshiok@gmail.com> wrote:
> > Arjan,
> >
> > On 6/25/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Sat, 2005-06-25 at 19:28 +0900, Hiro Yoshioka wrote:
> > > > Hi,
> > > >
> > > > I got the following OOM killer on 2.6.9 by iozone. The machine has a
> > > > i2o driver so it may have issues.
> > >
> > >
> > > 2.6.9 is a really really old kernel by now; you're probably much better
> > > off using 2.6.12
> >
> > Thanks for your help.
> >
> > It is RHEL 2.6.9-5.EL based kernel. I'll try to reproduce 2.6.12 kernel.
> >
> > Regards,
> >   Hiro
> >
> 
> I tried to reproduce on 2.6.12.1 but I could not get OOM.
> 
> Thanks,
>  Hiro
>
