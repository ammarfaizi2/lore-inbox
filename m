Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137099AbREKKjy>; Fri, 11 May 2001 06:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137100AbREKKjn>; Fri, 11 May 2001 06:39:43 -0400
Received: from 13dyn241.delft.casema.net ([212.64.76.241]:54793 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S137099AbREKKji>; Fri, 11 May 2001 06:39:38 -0400
Message-Id: <200105111039.MAA18522@cave.bitwizard.nl>
Subject: Re: Source code compatibility in Stable series????
In-Reply-To: <20010511123257.A6023@gruyere.muc.suse.de> from Andi Kleen at "May
 11, 2001 12:32:57 pm"
To: Andi Kleen <ak@suse.de>
Date: Fri, 11 May 2001 12:39:29 +0200 (MEST)
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org,
        davem@redhat.com
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, May 11, 2001 at 12:21:59PM +0000, Petr Vandrovec wrote:
> > When I was updating VMware's vmnet, I decided to use
> > 
> > #ifdef skb_shinfo
> 
> Yes I forgot that RedHat already shipped it :-(
> 
> > This gives you maximal backward compatibility, as all public zerocopy
> > patches contain this macro. Only thing is that Dave has to remember
> > that when he turns skb_shinfo into inline function, an identity #define have
> > to be added.
> 
> No such guarantee for binary only software ;)

Right. I therefore refuse to maintain binary modules for my
clients. This usually convinces them to release source code.

But it's always been said that source code compatiblity would be
maintained. I'm a bit pissed that people just go about changing public
source-level interfaces. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
