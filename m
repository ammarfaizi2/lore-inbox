Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129207AbQJ0TIm>; Fri, 27 Oct 2000 15:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129236AbQJ0TIc>; Fri, 27 Oct 2000 15:08:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:51980 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129207AbQJ0TIL>; Fri, 27 Oct 2000 15:08:11 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: missing mxcsr initialization
Date: 27 Oct 2000 12:07:58 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tcjqe$8te$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10010262229330.864-100000@penguin.transmeta.com> <E13p7te-0004MB-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E13p7te-0004MB-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> > 
> > and it appears to work again, until it turns out that Cyrix has the same
> > issue, and then it ends up being the test from hell, where different
> > vendor tests all clash, and it gets increasingly difficult to add a new
> > thing later on sanely. 
> 
> And you end up with mtrr.c
> 

Indeed.

> 
> > No thank you. We'll just require fixed feature flags. Which can be turned
> > on as the features are enabled.
> 
> That seems sensible
> 

I'm working on the patch right now.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
