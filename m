Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbTFBRUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbTFBRUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:20:40 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:27923 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264806AbTFBRUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:20:38 -0400
Date: Mon, 2 Jun 2003 14:34:50 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Juan Quintela <quintela@mandrakesoft.com>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030602173450.GD9312@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Steven Cole <elenstev@mesatop.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Juan Quintela <quintela@mandrakesoft.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306020856450.19910-100000@home.transmeta.com> <1054571980.3751.141.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054571980.3751.141.camel@spc9.esa.lanl.gov>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 02, 2003 at 10:39:41AM -0600, Steven Cole escreveu:
> On Mon, 2003-06-02 at 09:59, Linus Torvalds wrote:
> > On 2 Jun 2003, Juan Quintela wrote:
> > > 
> > > /**
> > >  * foo - <put something there>
> > >  * @bar: number of frobnicators
> > >  * @baz: self-larting on or off
> > >  * @userdata: pointer to arbitrary userdata to be registered
> > >  *
> > >  * Description: Please, fix me
> > >  */
> > > int foo(long bar, long baz)
> > > {
> > > ...
> > > 
> > > Looks like a better alternative to me.
> > 
> > Hey, if somebody were to send me a patch (hint hint), I'd happily apply 
> > it.
> > 
> > 		Linus
> 
> I sent this last night as an example, except now the function
> declaration is not wrapped.  How is this?
> 
> Steven
> 
> --- linux/lib/zlib_inflate/inftrees.c.orig	Mon Jun  2 10:15:29 2003
> +++ linux/lib/zlib_inflate/inftrees.c	Mon Jun  2 10:16:47 2003
> @@ -288,14 +288,16 @@
>    return y != 0 && g != 1 ? Z_BUF_ERROR : Z_OK;
> +int zlib_inflate_trees_bits(uIntf *c, uIntf *bb, inflate_huft * FAR *tb, inflate_huft *hp, z_streamp z)
>  {
>    int r;
>    uInt hn = 0;          /* hufts used in space */

I do it like this:


int zlib_inflate_trees_bits(uIntf *c, uIntf *bb, inflate_huft * FAR *tb,
			    inflate_huft *hp, z_streamp z)

- Arnaldo
