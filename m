Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317690AbSFLMLy>; Wed, 12 Jun 2002 08:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317691AbSFLMLx>; Wed, 12 Jun 2002 08:11:53 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:34823 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S317690AbSFLMLw>; Wed, 12 Jun 2002 08:11:52 -0400
Message-Id: <200206121211.g5CCBjZt030139@pincoya.inf.utfsm.cl>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets 
In-Reply-To: Message from Ben Greear <greearb@candelatech.com> 
   of "Tue, 11 Jun 2002 23:26:40 MST." <3D06E9A0.5060801@candelatech.com> 
Date: Wed, 12 Jun 2002 08:11:45 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc:'s stripped]

Ben Greear <greearb@candelatech.com> said:
> Pekka Savola wrote:
> > Just to chime in my support (not that I don't think anyone needs it), I 
> > think socket-based counters are An Extremely Bad Idea.  

[...]

> If they are useful to some people, and have zero performance affect on others
> (due to being a configurable kernel feature), then what is your
> complaint?

That it adds code, which impacts _everybody_ futzing around in that area,
specially if it is a configurable option (this means multiplying the
possible configurations to be tested).

> I see two reasons left to dislike this feature:
> 
> 1)  General increase in #ifdef'd code.  This actually seems like
>     a pretty good argument, but I haven't seen anyone mention it
>     specifically.

Right.

> 2)  General dislike for a feature that one personally has no use for.
>     Seems to be Dave's main (professed) excuse.

General dislike for adding features of _extremely_ limited (debugging!) use?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
