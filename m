Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264360AbUFCVlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbUFCVlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 17:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUFCVlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 17:41:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45822 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264360AbUFCVlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 17:41:02 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Herbert Poetzl <herbert@13thfloor.at>, "Zhu, Yi" <yi.zhu@intel.com>
Subject: Re: idebus setup problem (2.6.7-rc1)
Date: Thu, 3 Jun 2004 23:44:19 +0200
User-Agent: KMail/1.5.3
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Auzanneau Gregory <mls@reolight.net>, Jeff Garzik <jgarzik@pobox.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <3ACA40606221794F80A5670F0AF15F8403BD54FE@PDSMSX403.ccr.corp.intel.com> <20040603213115.GA1107@MAIL.13thfloor.at>
In-Reply-To: <20040603213115.GA1107@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406032344.19152.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 of June 2004 23:31, Herbert Poetzl wrote:
> On Thu, Jun 03, 2004 at 10:05:08PM +0800, Zhu, Yi wrote:
> > Rusty Russell wrote:
> > > Dislike this idea.  If you have hundreds of parameters, maybe it's
> > > supposed to be a PITA?
> >
> > What's your idea to make module_param support alterable param
> > names like ide3=xxx ?
>
> hmm, what about making all those something like:
>
> 	ide=3:foo,bar;4:wossname

We are in stable kernel and in 2.7 'idex=' and 'hdx=' will die.

> where ':' and ';' are arbitrarily chosen atm ...
> or, if it should be handled at the 'argument' level
> maybe the 'notion' of arrays would help, something
> like
>
> 	ide[3]=foo,bar
>
> where ide is defined as array of strings, size 16

Sounds awful.

Cheers,
Bartlomiej

