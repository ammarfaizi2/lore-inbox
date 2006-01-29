Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWA2DU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWA2DU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 22:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWA2DU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 22:20:57 -0500
Received: from pat.uio.no ([129.240.130.16]:63921 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750813AbWA2DU4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 22:20:56 -0500
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths
	library
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: Adrian Bunk <bunk@stusta.de>, Christoph Hellwig <hch@infradead.org>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060128165732.GA8633@hardeman.nu>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com>
	 <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com>
	 <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
	 <20060128104611.GA4348@hardeman.nu>
	 <1138466271.8770.77.camel@lade.trondhjem.org>
	 <20060128165732.GA8633@hardeman.nu>
Content-Type: text/plain; charset=utf-8
Date: Sat, 28 Jan 2006 22:20:29 -0500
Message-Id: <1138504829.8770.125.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.7, required 12,
	autolearn=disabled, AWL 1.11, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 17:57 +0100, David Härdeman wrote:

> What about the first paragraph of what I wrote? You are going to want to 
> keep often-used keys around somehow, proxy certificates is not a 
> solution for your own use of your personal keys and with the exception 
> of hardware solutions such as smart cards, the keys will be safer in the 
> kernel than in a user-space daemon...

I don't get this explanation at all.

Why would you want to use proxy certificates for you own use? Use your
own certificate for your own processes, and issue one or more proxy
certificates to any daemon that you want to authorise to do some limited
task.

...and what does this statement about "keys being safer in the kernel"
mean?

> Further, the mpi and dsa code can also be used for supporting signed 
> modules and binaries...the "store dsa-keys in kernel" part adds 376 
> lines of code (counted with wc so comments and includes etc are also 
> counted)...

Signed modules sounds like a better motivation, but is a full dsa
implementation in the kernel really necessary to achieve this?

Cheers,
  Trond

