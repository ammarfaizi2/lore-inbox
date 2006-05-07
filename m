Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWEGNdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWEGNdh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWEGNdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:33:37 -0400
Received: from mout1.freenet.de ([194.97.50.132]:20686 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932161AbWEGNdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:33:36 -0400
From: Joachim Fritschi <jfritschi@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/2]  Twofish cipher x86_64-asm optimized
Date: Sun, 7 May 2006 15:33:33 +0200
User-Agent: KMail/1.8.3
References: <200605071157.03362.jfritschi@freenet.de> <p73odya3ys9.fsf@bragg.suse.de> <20060507123353.GA4611@gondor.apana.org.au>
In-Reply-To: <20060507123353.GA4611@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071533.33791.jfritschi@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 14:33, Herbert Xu wrote:
> On Sun, May 07, 2006 at 12:38:30PM +0200, Andi Kleen wrote:
> > It would be good if you could run some random input encrypt/decrypt tests
> > comparing the C reference version with yours. We have had bad luck
> > with assembler functions not quite implementing the same cipher
> > in the past.
>
> That's a very good point.  The tcrypt module provides both correctness
> tests as well as speed tests for twofish.  Please run it with your
> version versus the existing implementation.

All tcrypt tests pass successfully on both architectures.

Here are the outputs from the tcrypt speedtests:

http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-i586.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-i586.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-c-x86_64.txt
http://homepages.tu-darmstadt.de/~fritschi/twofish/tcrypt-speed-asm-x86_64.txt

Regards,
Joachim


