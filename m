Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWHUA4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWHUA4K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWHUA4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:56:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932390AbWHUA4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:56:09 -0400
Date: Mon, 21 Aug 2006 02:56:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Andreas Steinmetz <ast@domdv.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060821005608.GD11651@stusta.de>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de> <17636.11747.89849.992490@alkaid.it.uu.se> <20060817124839.GR7813@stusta.de> <20060817204307.GA17391@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817204307.GA17391@1wt.eu>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 10:43:07PM +0200, Willy Tarreau wrote:

> Hi Adrian,

Hi Willy,

>...
> Basically, my goal is to keep all those users trusting Linux (other
> systems such as OpenBSD are very present in this area too). And your
> goal is to progressively attract them towards 2.6 with strong arguments
> in favor of 2.6 (and not against 2.4) that only them will judge relevant
> based on their usage. And I can tell you that 2.4 being harder to build
> than 2.6 is obviously not a relevant argument in favor of 2.6 for people
> who apply more than 100 patches to their kernels.

it was not my goal to make it harder for people to build 2.4.

I'd in fact consider userspace and hardware support the real problems 
for people who want to use kernel 2.4 - using a different compiler is
a relatively easy issue compared to this.

And I had mixed two complete different points in this thread:
- untested kernel 2.4 / gcc 4
- kernel 2.6 shouldn't be in any respect worse than kernel 2.4

Looking at the kenrel size, it seems the latter is far from being true 
in this respect.  :-(

The "untested" still applies.
But I do also understand your points regardingthis issue.

If I was 2.4 maintainer, I wouldn't apply the patch to allow gcc 4.
But you are the 2.4 maintainer, and it's therefore your decision.

> Best regards,
> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

