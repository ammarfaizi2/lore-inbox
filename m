Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266381AbRHFBTw>; Sun, 5 Aug 2001 21:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbRHFBTm>; Sun, 5 Aug 2001 21:19:42 -0400
Received: from [63.209.4.196] ([63.209.4.196]:25872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266417AbRHFBTX>; Sun, 5 Aug 2001 21:19:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Boot Failure
Date: 5 Aug 2001 18:18:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9kkr9t$mpo$1@cesium.transmeta.com>
In-Reply-To: <3B6C4C4C.D15A625C@telocity.com> <2295.996976445@ocs3.ocs-net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <2295.996976445@ocs3.ocs-net>
By author:    Keith Owens <kaos@ocs.com.au>
In newsgroup: linux.dev.kernel
>
> On Sat, 04 Aug 2001 15:26:04 -0400, 
> LeRoy Cressy <lcressy@telocity.com> wrote:
> >Starting with kernel 2.4.5 the system refused to boot with the following
> >messages:
> >2.4.7:
> >
> >CPU #0: Machine check exception 0x 106B60 (type 0x      9).
> 
> In arch/i386/kernel/bluesmoke.c, function intel_mcheck_init, find
>         if(c->x86 == 5)
>         {
> and insert 'return;' after '{'.  The P5 machine check handler does not
> work for all systems, reason unknown.
> 

What's the CPU, specifically?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
