Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750848AbWFEXfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWFEXfe (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWFEXfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:35:34 -0400
Received: from mx1.suse.de ([195.135.220.2]:34249 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750827AbWFEXfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:35:33 -0400
From: Andi Kleen <ak@suse.de>
To: Joachim Fritschi <jfritschi@freenet.de>
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Tue, 6 Jun 2006 01:35:26 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au
References: <200606041516.46920.jfritschi@freenet.de> <200606042110.15060.ak@suse.de> <200606051206.50085.jfritschi@freenet.de>
In-Reply-To: <200606051206.50085.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606060135.26823.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 12:06, Joachim Fritschi wrote:
> On Sunday 04 June 2006 21:10, Andi Kleen wrote:
> > On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
> > > This patch adds the twofish x86_64 assembler routine.
> > >
> > > Changes since last version:
> > > - The keysetup is now handled by the twofish_common.c (see patch 1 )
> > > - The last round of the encrypt/decrypt routines where optimized saving 5
> > > instructions.
> > >
> > > Correctness was verified with the tcrypt module and automated test
> > > scripts.
> >
> > Do you have some benchmark numbers that show that it's actually worth
> > it?
> 
> Here are the outputs from the tcrypt speedtests. They haven't changed much 
> since the last patch:

Ok thanks. I've tried to apply the patches, but can't because they're
word wrapped. Can you please resend and do a test send to yourself first,
checking that the patch can be really applied.


> There might be some way to further improve readability but i have not found 
> any other way. I'm open to suggestions :)


Sounds reasonable. Best you just fix the comment to say that this convention is needed 
for the macros.

-Andi
