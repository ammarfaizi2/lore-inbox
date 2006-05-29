Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWE2HId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWE2HId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWE2HId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:08:33 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:34570 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750712AbWE2HIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:08:32 -0400
Date: Mon, 29 May 2006 15:06:23 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu,
       Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use aio_read/aio_write
 instead
In-Reply-To: <4478EBAD.4060105@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0605291505340.3431@raven.themaw.net>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> 
 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> 
 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> 
 <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com> 
 <1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com> 
 <20060521180037.3c8f2847.akpm@osdl.org>  <1148310016.7214.26.camel@dyn9047017100.beaverton.ibm.com>
  <20060522100640.0710f7da.akpm@osdl.org>  <1148318671.7214.42.camel@dyn9047017100.beaverton.ibm.com>
  <4472C7E1.3060004@themaw.net> <1148394915.8788.4.camel@raven.themaw.net>
 <4478EBAD.4060105@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2006, Badari Pulavarty wrote:

> > > > 
> > > Doesn't seem to apply to 2.6.17-rc4.
> > > 
> > > [raven@raven linux-2.6.16]$ patch -p1 <
> > > ~/remove-readv_writev-methods-and-use-aio_read_aio_write.patch
> > > patching file drivers/char/raw.c
> > > 
> 
> This patch is the 2nd patch in the series. So you need to apply vectorize-aio
> methods
> patch first. Anyway, I am going to re-test and send out the series when I get
> back.

Oops.

Sorry.

Ian

