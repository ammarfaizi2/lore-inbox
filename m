Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272452AbRIFSUS>; Thu, 6 Sep 2001 14:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272445AbRIFSUK>; Thu, 6 Sep 2001 14:20:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27154 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272452AbRIFSTz>; Thu, 6 Sep 2001 14:19:55 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
 bug 2.4.9 and 2.2.19]
Date: 6 Sep 2001 11:20:06 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9n8eom$qab$1@cesium.transmeta.com>
In-Reply-To: <20010906193750.B22187@castle.nmd.msu.ru> <20010906155811.BC78DBC06C@spike.porcupine.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010906155811.BC78DBC06C@spike.porcupine.org>
By author:    wietse@porcupine.org (Wietse Venema)
In newsgroup: linux.dev.kernel
>
> Andrey Savochkin:
> > Of course, SIOCGIFCONF isn't even close to provide the list of local
> > addresses.
> > Obvious example: it doesn't enlist all addresses 127.0.0.1, 127.0.0.2 etc.
> > on common systems.  If you handle 127.0.0.2 as local, you apply side
> 
> 127.0.0.2 is not local on any of my systems. The only exceptions
> are some Linux boxen that I did not ask to do so.
> 

The RFCs declare that 127.0.0.0/8 is all local.  If what you write is
true, all your systems are noncompliant.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
