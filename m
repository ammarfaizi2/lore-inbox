Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272223AbRHWIsi>; Thu, 23 Aug 2001 04:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272234AbRHWIs1>; Thu, 23 Aug 2001 04:48:27 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:52391 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S272223AbRHWIsU>;
	Thu, 23 Aug 2001 04:48:20 -0400
Date: Thu, 23 Aug 2001 10:48:28 +0200
From: David Weinehall <tao@acc.umu.se>
To: Evgeny Polyakov <johnpol@2ka.mipt.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] this patch add a possibility to add a random offset to the stack on exec.
Message-ID: <20010823104828.C1434@khan.acc.umu.se>
In-Reply-To: <200108230130.f7N1Uol14698@www.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200108230130.f7N1Uol14698@www.2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Thu, Aug 23, 2001 at 05:32:10AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2001 at 05:32:10AM +0400, Evgeny Polyakov wrote:
> Hello, linux-guru.
> 
> A couple of days ago Artur Grabovsky add this thing into the OpenBSD(
> someone guess, this is the most secure OS) kernel.
> This, as he suppose, not improve security of the system, but do OS more
> strong to the script-kiddies attack.
> Althought all admins and security analysist are loudly speaking, that
> Linux is the greatest hole in security aspect, i think, that with straight
> /dev/hands and not stupid /dav/brain the system can be unbreakable.
> But there are situations, when even the best administrator cann't fight
> against script-kiddies becouse of vendors, that cann't patch it's soft in
> time.
> And many systems lost it's defense.
> In this cases many things can help, for example nonexecutable stack.
> This patch also helps in manner of this kind.
> If machine has random stack base in any exec, script kiddies will not
> write _simple_ exploits, becouse of allmost such programs beleive, that
> stack base remains the same.
> And script kiddies should learn much more complex methods, like rewriting
> dtors section and other.
> In this case this patch cann't help, but i however belive, that this is
> not bad.

Oh my $DEITY, not this discussion again.

Look, this kind of patches (non-executable stacks, etc.) surfaces
at least twice a year, causes a two-three weeks long discussion
(flame-war), then dies. Linus hasn't taken such a patch into the
kernel so far. Neither has Alan.

Let it rest, or contact Linus directly in about a week or two (when
he has returned from his vacation) and as him if he a.) has changed
his mind, and if so, b.) thinks your patch looks good.


/David Weinehall

PS: If I remember correctly, Theodore T'so is the person who was most
capable to shoot down this idea. Sorry if I'm wrong on that account.
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
