Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTFOAyl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 20:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTFOAyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 20:54:40 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:5640 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261710AbTFOAyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 20:54:39 -0400
Date: Sat, 14 Jun 2003 22:10:17 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: John Weber <weber@sixbit.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.71
Message-ID: <20030615011017.GH26644@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	John Weber <weber@sixbit.org>, linux-kernel@vger.kernel.org
References: <3EEB9FF1.7090104@sixbit.org> <E19RLc2-0006Ud-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19RLc2-0006Ud-00@gondolin.me.apana.org.au>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jun 15, 2003 at 10:43:14AM +1000, Herbert Xu escreveu:
> John Weber <weber@sixbit.org> wrote:
> > Rather trivial patch, but it looks like it's needed.
> > 
> > --- flow.old    2003-06-14 18:17:35.000000000 -0400
> > +++ flow.c      2003-06-14 18:13:03.000000000 -0400
> > @@ -5,6 +5,7 @@
> >   */
> > 
> >  #include <linux/kernel.h>
> > +#include <linux/cpu.h>
> >  #include <linux/list.h>
> >  #include <linux/jhash.h>
> >  #include <linux/interrupt.h>
> 
> Never mind, I see it now.  Thanks for the fix.

I already did this and it is in DaveM's tree, thanks anyway.

- Arnaldo
