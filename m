Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288675AbSA0VJb>; Sun, 27 Jan 2002 16:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288685AbSA0VJU>; Sun, 27 Jan 2002 16:09:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10762 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288675AbSA0VJF>; Sun, 27 Jan 2002 16:09:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: CRAP in 2.4.18-pre7
Date: 27 Jan 2002 13:08:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a31q91$upd$1@nell.transmeta.com>
In-Reply-To: <20020126171545.GB11344@fefe.de> <3C542FE6.7C56D6BD@mandrakesoft.com> <3C5439C1.6000305@evision-ventures.com> <3C543E86.7F0FA37A@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C543E86.7F0FA37A@gmx.net>
By author:    root <gunther.mayer@gmx.net>
In newsgroup: linux.dev.kernel
> 
> You don't need a hub to have collisions.
> 
> Duplex mismatch (i.e. one card in full-duplex, the other in half-duplex)
> would just show 10-50 KByte/sec transfer rates typically.
> 
> The card's statistics about "collisions" and "late collisions" would
> positively prove if this is the case.
> 

Not all cards correctly autoconfigure across a crossover cable (they
should, but not all do).  When autoconfigure is screwed up, as you
indicate above, things will be *VERY* messed up.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
