Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWI0SiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWI0SiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 14:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWI0SiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 14:38:08 -0400
Received: from relay03.pair.com ([209.68.5.17]:40711 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S965147AbWI0SiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 14:38:07 -0400
X-pair-Authenticated: 71.197.50.189
Date: Wed, 27 Sep 2006 13:37:37 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0609271300130.7316@turbotaz.ourhouse>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <1159319508.16507.15.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
  <1159342569.2653.30.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
 <1159359540.11049.347.camel@localhost.localdomain> <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006, Linus Torvalds wrote:

>
> For example, I could write a copyright license that said
>
> 	"This license forbids you from ever copying the kernel, or any
> 	work made by Leo Tolstoy, which is just a pseudonym for the
> 	easter bunny"
>
> and the fact that the license claims to control the works of Leo "the
> easter bunny" Tolstoy, claiming so simply doesn't make it so.
>
> And yes, the above is obviously ridiculous, but the point is, it's no more
> ridiculous than a license that would claim that it extends to programs
> just because you can run then on Linux.
>
> In fact, it's also no more ridiculous than a license that claims it
> extends copyright the other way - to the hardware or platform that you run
> a program on. From a legal standpoint, such wording is just totally
> idiotic.
>

The reason a clause such as that will work is that people have no natural 
right to redistribute Linux. To invoke the FSF's Tivo example, if the Tivo 
company wants to stamp out 5,000 Tivo boxes, they're going to make 5,000 
copies of Linux in the process. By default and by direct notice, the 
pieces that make up Linux, and the compilation of Linux itself, is 
copyrighted. This totally prohibits Tivo from making legal copies.

If Tivo wants to redistribute Linux, they need a license. That license is 
GPLv2, but let us assume for a moment that rms spiked the punch at OLS and 
the kernel became GPLv3. If GPLv3 says "You may not make copies of the 
covered work unless you agree to these terms", and one term says, "You 
must not use technological means to override a stated license freedom", 
then Tivo redistributes Linux anyway inside a device that uses 
technological means (signed code, for instance) to override a stated 
freedom, Tivo is breaking the law, unless every Linux copyright holder 
agreed to give Tivo a special exception (aka license).

So regardless of whether or not you think such a term is ridiculous, it is 
enforceable. The only place I am aware that law might deliberately reduce 
the scope of a license's requirements is to uphold fair use rights, or 
along the same lines, to ensure fair treatment of a consumer that has paid 
money for something and is being subjected to unreasonable coercion by the 
copyright holder of what they have paid for.

If you haven't paid for a copyrighted work, and the copies you want to 
make do not fall under fair use ("we needed a cheap and good operating 
system for our embedded device" is not in that category), you need to obey 
the license or find something else to copy.

I don't want to get ensnared in another licensing debate about code I have 
no moral or legal claim to, but I do want to thank those of you behind the 
position statement. I'm not sure I agree with your points but I think the 
dialogue itself is important.

The last thing that I want to say is that I wish people wouldn't imply to 
the press (wink wink, nudge nudge, Linus) that the FSF is evil. I've heard 
at various times the following things in the press:

1. "The FSF is not going to listen to anyone about GPLv3"
2. "The FSF is not listening to anyone about the GPLv3"
3. "I don't want to participate in the GPLv3 process"
4. "The FSF knows my views because I have carbon-copied them"

...meanwhile, the FSF is allegedly trying to open up a dialogue. I think 
the important distinction is that the FSF will listen to anything the 
kernel people (or anyone else for that matter) say, but whatever is said 
will be interpreted and balanced in the context of the FSF's original 
goals of the license, Freedoms 0-3, and most certainly what they believe 
those Freedoms to be.

I think one thing that should have happened a _lot_ sooner is that you and 
others should have made clear to the startled community that you object 
precisely to the anti-Tivoization clause, not because of any technical 
reason or interpretation but because you don't see anything wrong with 
Tivo's use of Linux. It would have been nice but totally optional to 
engage in dialogue with the FSF. But slandering them about their license 
development process, or their intentions with regard to using Linux as 
leverage, is counterproductive whether true or not.

I'm one of those lefty "free software" types, though I don't disbelieve 
in "open source" either. At this point, I consider it likely that I'll use 
the GPLv3 for any software I independently develop, and I'll continue to 
be damn thankful that I have the best operating system kernel ever in 
history to freely run that code on. When I submit a patch to Linux, I'll 
happily do so knowing that it will be licensed underneath the wonderful 
GPLv2.

The reason I wrote this long message is that despite having never met any 
of you, I consider you all friends. We're software developers working for 
a common good, even if we see it a different way. I hope that's enough to 
make me your friends as well. If that is the case, and we're all friends 
here, let's be fair to the FSF even if we don't agree with them, and even 
if some of their members haven't been fair to us in the past.

Thanks,
Chase Venters
