Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262761AbRFEGLM>; Tue, 5 Jun 2001 02:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbRFEGKx>; Tue, 5 Jun 2001 02:10:53 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46858 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263238AbRFEGKs>; Tue, 5 Jun 2001 02:10:48 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] fs/devfs/base.c
Date: 4 Jun 2001 23:10:27 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9fht4j$cce$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com> <E156o6c-0005AB-00@the-village.bc.nu> <200106040707.f5477ET11421@vindaloo.ras.ucalgary.ca> <m2elt011y6.fsf@sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m2elt011y6.fsf@sympatico.ca>
By author:    Bill Pringlemeir <bpringle@sympatico.ca>
In newsgroup: linux.dev.kernel
> 
> There was a discussion on comp.arch.embedded about bounded stack use.
> It is fairly easy to calculate the stack usage for call trees, but
> much more difficult for `DAGs'.  Ie, a recursive functions etc.
> 

It's trivial to calculate for DAGs -- directed acyclic graphs.  It's
when the "acyclic" constraint is violated that you have problems!

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
