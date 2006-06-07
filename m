Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWFGTVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWFGTVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWFGTVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:21:14 -0400
Received: from mout2.freenet.de ([194.97.50.155]:13506 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932371AbWFGTVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:21:13 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Wed, 7 Jun 2006 21:21:11 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       herbert@gondor.apana.org.au
References: <200606041516.46920.jfritschi@freenet.de> <200606051206.50085.jfritschi@freenet.de> <200606060135.26823.ak@suse.de>
In-Reply-To: <200606060135.26823.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606072121.11640.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 June 2006 01:35, Andi Kleen wrote:
> On Monday 05 June 2006 12:06, Joachim Fritschi wrote:
> > On Sunday 04 June 2006 21:10, Andi Kleen wrote:
> > > On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
> > > > This patch adds the twofish x86_64 assembler routine.
> > > >
> > > > Changes since last version:
> > > > - The keysetup is now handled by the twofish_common.c (see patch 1 )
> > > > - The last round of the encrypt/decrypt routines where optimized saving 5
> > > > instructions.
> > > >
> > > > Correctness was verified with the tcrypt module and automated test
> > > > scripts.
> > >
> > > Do you have some benchmark numbers that show that it's actually worth
> > > it?
> > 
> > Here are the outputs from the tcrypt speedtests. They haven't changed much 
> > since the last patch:
> 
> Ok thanks. I've tried to apply the patches, but can't because they're
> word wrapped. Can you please resend and do a test send to yourself first,
> checking that the patch can be really applied.

Sorry i will send new patches, also including the fixes that were suggested by Dag.

-Joachim

