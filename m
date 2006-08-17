Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWHQMsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWHQMsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWHQMsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:48:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25094 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932371AbWHQMsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:48:40 -0400
Date: Thu, 17 Aug 2006 14:48:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andreas Steinmetz <ast@domdv.de>, Arjan van de Ven <arjan@infradead.org>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060817124839.GR7813@stusta.de>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de> <17636.11747.89849.992490@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17636.11747.89849.992490@alkaid.it.uu.se>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 10:50:43AM +0200, Mikael Pettersson wrote:
> Andreas Steinmetz writes:
>  > Arjan van de Ven wrote:
>  > > But maybe it's worth doing a user survey to find out what the users of
>  > > 2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
>  > > people who use enterprise distro kernels don't count for this since
>  > > they'll not go to a newer released 2.4 anyway)
>  > 
>  > Currently I'm working with ARM based embedded systems. I prefer 2.4
>  > kernels to 2.6 as they are smaller thus leaving more flash for jffs2.
>  > Not speaking of the kernel a gcc 4.1.1 compile of code for a LPC2103
>  > resulted in a clearly smaller binary as the same compile with gcc 3.4.
>  > Thus I really would like to be able to use gcc 4.x with 2.4 kernels.
>  > There are even kernel miscompiles with gcc 3.4 that might be fixed with
>  > gcc 4 (one has to try).
> 
> I've done a fair amount of ARM user-space hacking recently, and the
> number of bug fixes one has to apply to gcc-3.3 or gcc-3.4 to make it
> even semi-correct on ARM is scary. Since these versions aren't supported
> any more, being able to use newer, hopefully less buggy, and _supported_
> gcc versions is clearly beneficial.
> 
> Of course, this is not an issue for x86 users.

The only valid point I see for still using kernel 2.4 is
"never touch a running system".

But your ARM work seems to be new development.

If there are any problems preventing people from switching to kernel 2.6 
when deploying new systems (e.g. increased kernel size), we should get 
these problems reported and fixed in kernel 2.6.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

