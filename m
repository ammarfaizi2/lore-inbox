Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319077AbSH1XXS>; Wed, 28 Aug 2002 19:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319103AbSH1XXS>; Wed, 28 Aug 2002 19:23:18 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:44792 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319077AbSH1XXR>; Wed, 28 Aug 2002 19:23:17 -0400
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0208281406190.16824-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208281406190.16824-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 00:30:06 +0100
Message-Id: <1030577406.7190.89.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 22:08, Linus Torvalds wrote:
> 
> On Wed, 28 Aug 2002, Dominik Brodowski wrote:
> > 
> > "policy input" --> "frequency input" --> cpufreq core --> cpufreq driver
> >   user-space    |                 k e r n e l  -  s p a c e
> 
> No.
> 
> The "policy input" has to filter down ALL THE WAY. If you turn it into a 
> frequency-only input at _any_ time, you've lost information that the 
> lowest levels need. 

So what you are saying is that you want to be sure that something like
"please run at a low speed to save battery" is translated by smarter
cpus into "please save battery" and on spudstop the CPU would go "umm
duh ok 300MHz"

Ok now I think I understand your gripe.




