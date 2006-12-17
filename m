Return-Path: <linux-kernel-owner+w=401wt.eu-S1751561AbWLQB4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWLQB4L (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 20:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWLQB4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 20:56:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4955 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751561AbWLQB4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 20:56:09 -0500
Date: Sun, 17 Dec 2006 02:56:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Willy Tarreau <w@1wt.eu>, karderio <karderio@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061217015609.GB10316@stusta.de>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org> <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org> <20061216064344.GF24090@1wt.eu> <Pine.LNX.4.64.0612160820240.3557@woody.osdl.org> <20061216164947.GB31013@1wt.eu> <Pine.LNX.4.64.0612160858100.3557@woody.osdl.org> <20061216183301.GA14286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216183301.GA14286@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 01:33:01PM -0500, Dave Jones wrote:
> On Sat, Dec 16, 2006 at 09:20:15AM -0800, Linus Torvalds wrote:
> 
>  > Anything else, you have to make some really scary decisions. Can a judge 
>  > decide that a binary module is a derived work even though you didn't 
>  > actually use any code? The real answer is: HELL YES. It's _entirely_ 
>  > possible that a judge would find NVidia and ATI in violation of the GPLv2 
>  > with their modules.
> 
> ATI in particular, I'm amazed their lawyers OK'd stuff like..
> 
> +ifdef STANDALONE
>  MODULE_LICENSE(GPL);
> +endif
> 
> This a paraphrased diff, it's been a while since I've seen it.
> It's GPL if you build their bundled copy of the AGPGART code as agpgart.ko,
> but the usual use case is that it's built-in to fglrx.ko, which sounds
> incredibly dubious.
>...

Current versions contain
  MODULE_LICENSE("GPL and additional rights");
...

> The thing that really ticks me off though is the free support ATI seem
> to think they're entitled to.  I've had end-users emailing me
> "I asked ATI about this crash I've been seeing with fglrx, and they
>  asked me to mail you".
> 
> I invest my time into improving free drivers.  When companies start
> expecting me to debug their part binary garbage mixed with license
> violations, frankly, I think they're taking the piss.
> 
> A year and a half ago, I met an ATI engineer at OLS, who told me they
> were going to 'resolve this'.  I'm still waiting.
> I live in hope that the AMD buyout will breathe some sanity into ATI.
> Then again, I've only a limited supply of optimism.

But who's actually taking legal actions?

Perhaps pending legal changes that will turn copyright violations into 
crimes might help to take legal actions without the legal risks of
civil trials.

Otherwise, it seems to be highly unlikely that anyone will want to sue a 
company that is often located in a different country, and the only 
possible legal action will be cease and desist letters against people 
who are infriding the copyright by e.g. selling Linux distributions 
containing fglrx at Ebay or operating Debian ftp mirrors. That sounds 
highly unfair, but unfortunately it also seems to be the only effective 
way for someone without a big wallet to effectively act against such 
licence violations...

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

