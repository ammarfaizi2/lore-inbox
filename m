Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135336AbRDLV2j>; Thu, 12 Apr 2001 17:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135337AbRDLV2a>; Thu, 12 Apr 2001 17:28:30 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44550 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135336AbRDLV2Q>; Thu, 12 Apr 2001 17:28:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
Date: 12 Apr 2001 14:27:43 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9b56kf$a8n$1@cesium.transmeta.com>
In-Reply-To: <200104121901.MAA04011@adam.yggdrasil.com> <m38zl6rkun.fsf@otr.mynet.cygnus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m38zl6rkun.fsf@otr.mynet.cygnus.com>
By author:    Ulrich Drepper <drepper@redhat.com>
In newsgroup: linux.dev.kernel
>
> "Adam J. Richter" <adam@yggdrasil.com> writes:
> 
> > >Shouldn't a compiler be able to deal with this instead?
> > 
> > 	Yes.
> 
> No.  gcc must not do this.  There are situations where you must place
> a zero-initialized variable in .data.  It is a programmer problem.
> 

And this cannot be decorated with __attribute__((section(".data")))
why?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
