Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUEBAXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUEBAXV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUEBAXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:23:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:33992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262768AbUEBAXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:23:19 -0400
Date: Sat, 1 May 2004 17:22:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Boucher <marc@linuxant.com>
cc: rusty@rustcorp.com.au, tconnors+linuxkernel1083378452@astro.swin.edu.au,
       linux-kernel@vger.kernel.org, riel@redhat.com, mbligh@aracnet.com,
       Sean Estabrooks <seanlkml@rogers.com>, nico@cam.org
Subject: Re: [PATCH] clarify message and give support contact for non-GPL
 modules
In-Reply-To: <3114F1F7-9BC7-11D8-B83D-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.58.0405011713110.18014@ppc970.osdl.org>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
 <Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home> <20040501205336.GA27607@valve.mbsi.ca>
 <20040501173450.006bae55.seanlkml@rogers.com> <3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com>
 <Pine.LNX.4.58.0405011541330.18014@ppc970.osdl.org>
 <3114F1F7-9BC7-11D8-B83D-000A95BCAC26@linuxant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 May 2004, Marc Boucher wrote:
> 
> As  previously mentioned, I have offered many patches and a lot of 
> source to the community throughout the last 15 years. Either personally 
> or via Linuxant, under various licenses (including the GPL) depending 
> on the constraints imposed by each situation, and continue doing so.

Marc, this is not anything person about you.

Think of it this way: what if _I_ were to make a binary-only module, and 
I'd claim that because I've given a lot to Linux, that binary-only module 
would be somehow ok, because while that module itself doesn't help other 
developers, I've done so using other means?

Would that make sense? Hell no. That would be equally wrong as if any 
all-binary-never-released-source person would do it.

So I'm not claiming that _you_ don't give anything back. It's purely about 
the module, which is not giving anything back to developers, and as such 
you shouldn't expect us to respect it.

> The modules in question are not binary-only, but mixed source/binary. 
> With the submitted patch, we are also offering to take as much support 
> burden off the community by clarifying the messages to explicitly 
> direct users to where they should go for help when using third-party 
> modules.

Yes, I think that patch in general makes sense. But I literally _do_ want 
people to be alarmed about tainting, because it's a DAMN BIG issue. 
Suddenly you go from a system that is openly supported by a lot of 
individuals and a number of companies, to one that is not. It's literally 
the difference between "open" and "proprietary", and that is an IMPORTANT 
difference. 

So I don't see how you can really try to minimize that HUGE difference, 
without effectively saying that you don't respect the work and the ethics 
that have gone into Linux in the first place.

See what I'm saying? A proprietary module is more a fundamental issue than
you seem to give it credit for being, and users should be told in big 
blinking neon letters about it.

			Linus
