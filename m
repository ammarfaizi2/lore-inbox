Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289076AbSAIX1f>; Wed, 9 Jan 2002 18:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289075AbSAIX10>; Wed, 9 Jan 2002 18:27:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16138 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289074AbSAIX1I>; Wed, 9 Jan 2002 18:27:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Date: 9 Jan 2002 15:26:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1ijjp$hbf$1@cesium.transmeta.com>
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com> <20020109154425.A28755@thyrsus.com> <20020109230704.A25786@devcon.net> <20020109165658.A31246@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020109165658.A31246@thyrsus.com>
By author:    "Eric S. Raymond" <esr@thyrsus.com>
In newsgroup: linux.dev.kernel
>
> Andreas Ferber <aferber@techfak.uni-bielefeld.de>:
> > Then add an init script and include installation of it to the
> > installation steps of your autoconfigurator (it has to be installed
> > anyway). If a distributor packages your program, he will include the
> > init script into his package and enable it according to his init
> > policy, or write an own init script, if your provided one doesn't
> > fit.
> > 
> > That's the way it works for network daemons etc. for years.
> 
> This sounds like good advice.  The autoconfigurator is part of CML2,
> which I expect to be distributed with the kernel.  Does that change 
> your advice at all?
> 

The program at hand is actually dmiparse or whatever it's called.  If
dmiparse isn't available, or its input data, print an eror message.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
