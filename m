Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161175AbVKRUYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbVKRUYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161177AbVKRUYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:24:12 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:57824 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161154AbVKRUYK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:24:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EfXl4DMjR/88J+VPodwQAb7x/fLMm7/n32yLaT2rRqRaHoI7vEkuxZmyHk44Otoo04cqnWLPCjR8c7CsSEkXS76S318svZOumKy9dHjzjD4VHO9ntH+C1HNwjqOm8vaHeMz664HBiqprCWCT4iOyq6aBbO/J93dUStJWHkp1N28=
Message-ID: <39e6f6c70511181224r20801b61j87c856c703ab2b4d@mail.gmail.com>
Date: Fri, 18 Nov 2005 18:24:10 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] move some code to net/ipx/af_ipx.c
Cc: Matt Mackall <mpm@selenic.com>, acme@conectiva.com.br,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20051118052252.GG11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6.282480653@selenic.com> <7.282480653@selenic.com>
	 <20051114015707.GB5735@stusta.de> <20051118052252.GG11494@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Nov 14, 2005 at 02:57:07AM +0100, Adrian Bunk wrote:
> > On Fri, Nov 11, 2005 at 02:35:51AM -0600, Matt Mackall wrote:
> > > trivial: drop unused 802.3 code if we compile without IPX
> > >
> > > (originally from http://wohnheim.fh-wedel.de/~joern/software/kernel/je/25/)

Thanks Adrian, from a quick glance looks OK, I'll review it later
today to see if everything is fine wrt appletalk, tr, etc.

- Arnaldo
