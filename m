Return-Path: <linux-kernel-owner+w=401wt.eu-S965010AbWL1WKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWL1WKf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWL1WKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:10:35 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:35114 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965010AbWL1WKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:10:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=iYnGUMeLuhghtrb55k4IMGHibLHgUIEmYAWhiBS52hD41skdugjOXnkxr1F+baQHOj4gTwjYEMzJw/3PaUwJRZA+XgETKD460ecHpLhJ3EwVtAUIzvQuXCV+RfUVlk/fPEUelctwxj6tOP5dOFVWFbjiBbQYg+nS4D+gaOd9nV0=  ;
X-YMail-OSG: knpq8.MVM1kNU7NvrGAh0QQp3GA.j0J2oOPyI5nSYemmmIiC.IVj2ayKtuVgqDON_YHzp264K8i55WmuieUPPKtXVPZofkgRkHqgYmKNlWvi0dibmmG2a5UYbs8qfuhkiL7nDxBT1IMuQTc-
From: David Brownell <david-b@pacbell.net>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 2.6.12-rc2] PNP: export pnp_bus_type
Date: Thu, 28 Dec 2006 14:10:31 -0800
User-Agent: KMail/1.7.1
Cc: Adam Belay <abelay@novell.com>, ambx1@neo.rr.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200612271347.47114.david-b@pacbell.net> <200612271559.02077.david-b@pacbell.net> <1167300302.3281.4181.camel@laptopd505.fenrus.org>
In-Reply-To: <1167300302.3281.4181.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612281410.31981.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 2:05 am, Arjan van de Ven wrote:
> 
> > Hmm, then maybe it'd be worth updating that patch I just sent so that
> > the only change is to switch #includes for the extern decl ... i.e. to
> > "export" it only to other statically linked kernel code, rather than to
> > modules.  I'll do that.
> > 
> > My own question about that EXPORT_SYMBOL was whether it instead be
> > an EXPORT_SYMBOL_GPL, but if either one costs bytes ... I'm happy to
> > avoid that cost!
> 
> no export if it's not *really* need is obviously superior to either of
> those so yes I like the patch you're talking about already without even
> having seen it ;)

The change is trivial ... in pnp/driver.c strike the EXPORT_SYMBOL.
So I won't bother posting it to this list; I hate wasting electrons.

I sent the updated patch to Andrew, but evidently just missed his
2.6.20-rc2-mm1 cutoff.

- Dave

