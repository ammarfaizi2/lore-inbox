Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275285AbTHSBpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275286AbTHSBpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:45:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63748 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S275285AbTHSBpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:45:53 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: headers
Date: 18 Aug 2003 18:45:21 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bhrvfh$394$1@cesium.transmeta.com>
References: <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
>
>     From garzik@gtf.org  Mon Aug 18 20:14:47 2003
> 
>     I support include/abi, or some other directory that segregates
>     user<->kernel shared headers away from kernel-private headers.
> 
>     I don't see how that would be auto-generated, though.  Only created
>     through lots of hard work :)
> 
> Yes, unfortunately. I started doing some of this a few times,
> but it is an order of magnitude more work than one thinks at first.
> Already the number of include files is very large.
> And the fact that it is not just include/abi but involves the architecture
> doesn't make life simpler.
> 
> No doubt we must first discuss a little bit, but not too much,
> the desired directory structure and naming.
> Then we must do 5% of the work, and come back to these issues.
> 
> In case people actually want to do this, I can coordinate.
> 
> In case people want to try just one file, do signal.h.
> 

Oh yes, this is a whole lot of work.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
