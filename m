Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUEBBC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUEBBC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 21:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUEBBCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 21:02:25 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:44992 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S262873AbUEBBCX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 21:02:23 -0400
In-Reply-To: <Pine.LNX.4.58.0405011713110.18014@ppc970.osdl.org>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home> <20040501205336.GA27607@valve.mbsi.ca> <20040501173450.006bae55.seanlkml@rogers.com> <3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.58.0405011541330.18014@ppc970.osdl.org> <3114F1F7-9BC7-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.58.0405011713110.18014@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5CDEE054-9BD4-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, riel@redhat.com,
       tconnors+linuxkernel1083378452@astro.swin.edu.au, mbligh@aracnet.com,
       Sean Estabrooks <seanlkml@rogers.com>, nico@cam.org
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] clarify message and give support contact for non-GPL modules
Date: Sat, 1 May 2004 21:02:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 1, 2004, at 8:22 PM, Linus Torvalds wrote:
>
> So I'm not claiming that _you_ don't give anything back. It's purely 
> about
> the module, which is not giving anything back to developers, and as 
> such
> you shouldn't expect us to respect it.

The HSF modules give back what they can right now, which is all 
operating system source, in an attempt to strike a reasonable 
compromise.

>
>> The modules in question are not binary-only, but mixed source/binary.
>> With the submitted patch, we are also offering to take as much support
>> burden off the community by clarifying the messages to explicitly
>> direct users to where they should go for help when using third-party
>> modules.
>
> Yes, I think that patch in general makes sense.

ok

> But I literally _do_ want
> people to be alarmed about tainting, because it's a DAMN BIG issue.
> Suddenly you go from a system that is openly supported by a lot of
> individuals and a number of companies, to one that is not. It's 
> literally
> the difference between "open" and "proprietary", and that is an 
> IMPORTANT
> difference.

Understood. So perhaps we should call it "open" and "proprietary" which 
are clear, well known words. "tainted" is honestly confusing/hard to 
understand for many ordinary users, especially international/non-native 
speakers who do not encounter the word that often (thankfully ;-).

>
> So I don't see how you can really try to minimize that HUGE difference,
> without effectively saying that you don't respect the work and the 
> ethics
> that have gone into Linux in the first place.
>
> See what I'm saying? A proprietary module is more a fundamental issue 
> than
> you seem to give it credit for being, and users should be told in big
> blinking neon letters about it.

Yes, I see what you are saying and agree that the user should be told 
*once* about the proprietary module, but I don't know how you will 
manage to make it look like blinking neon from within the kernel ;-)

Marc

>
> 			Linus
>

