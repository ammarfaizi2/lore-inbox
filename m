Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbRFUL2B>; Thu, 21 Jun 2001 07:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264930AbRFUL1v>; Thu, 21 Jun 2001 07:27:51 -0400
Received: from [142.176.139.106] ([142.176.139.106]:62724 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S264919AbRFUL1p>;
	Thu, 21 Jun 2001 07:27:45 -0400
Date: Thu, 21 Jun 2001 08:27:35 -0300 (ADT)
From: Ted Gervais <ve1drg@ve1drg.com>
To: Pete Toscano <pete@toscano.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_tables/ipchains
In-Reply-To: <20010620215302.A4636@bubba.toscano.org>
Message-ID: <Pine.LNX.4.21.0106210827130.3230-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001, Pete Toscano wrote:

> I had a similar problem with this yesterday.  Try moving your .config
> file to a safe place, making mrproper, then moving your .config back and
> rebuilding.  I did this and all was well.
> 
> HTH,
> pete


Thanks Pete. I will give that a try..



> 
> On Wed, 20 Jun 2001, Ted Gervais wrote:
> 
> > Wondering something..
> > I ran insmod to bring up ip_tables.o and I received the following error:
> > 
> > /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> > symbol nf_unregister_sockopt
> > /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> > symbol nf_register_sockopt
> > 
> > This is with kernel 2.4.5 and Slackware 7.1 is the distribution.
> > Does anyone know what these unresolved symbols are about??
> 

---
Doubt is not a pleasant condition, but certainty is absurd.
                -- Voltaire
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


