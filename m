Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTFTREU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTFTRET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:04:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15786 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263542AbTFTRDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 13:03:22 -0400
Date: Fri, 20 Jun 2003 14:14:50 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Robert Love <rml@tech9.net>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC][PATCH] CONFIG_NR_CPUS for 2.4.21
In-Reply-To: <1055984673.8770.9.camel@localhost>
Message-ID: <Pine.LNX.4.55L.0306201414070.12409@freak.distro.conectiva>
References: <20030618222336.GC3768@werewolf.able.es>  <20030618230136.GG3768@werewolf.able.es>
 <1055984673.8770.9.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jun 2003, Robert Love wrote:

> On Wed, 2003-06-18 at 16:01, J.A. Magallon wrote:
>
> > Oops, credits for this should go to (and possible comments/reject come
> > from) Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
>
> It looks fine to me, although I do not think this is as critical an
> issue as it was for 2.5, because the per-processor bloat is not nearly
> as bad in 2.4 as 2.5. Nonetheless, this does not actually break
> anything.
>
> Except, I notice in some places (namely, 64-bit architectures), you set
> the default NR_CPUS value to 64. While this ought to work if
> sizeof(unsigned long)==8, it might not and is probably not a change we
> want in a stable series. The default should be 32 all around.

Magallon,

Please change the default to 32 everywhere and I'll reconsider it.
