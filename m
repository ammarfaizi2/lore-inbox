Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUEAChd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUEAChd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 22:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUEAChd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 22:37:33 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:7176 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261764AbUEAChb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 22:37:31 -0400
To: Timothy Miller <miller@techsource.com>
Cc: Marc Boucher <marc@linuxant.com>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
From: Tim Connors <tconnors+linuxkernel1083378452@astro.swin.edu.au>
Subject: Re:  A compromise that could have been reached.  Re: [PATCH] Blacklist  binary-only modules lying about their license
In-reply-to: <4092C751.9060603@techsource.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <4092BB75.7050400@techsource.com> <58E313D6-9AEA-11D8-B83D-000A95BCAC26@linuxant.com> <4092C751.9060603@techsource.com>
X-Face: "/6m>=uJ8[yh+S{nuW'%UG"H-:QZ$'XRk^sOJ/XE{d/7^|mGK<-"*e>]JDh/b[aqj)MSsV`X1*pA~Uk8C:el[*2TT]O/eVz!(BQ8fp9aZ&RM=Ym&8@.dGBW}KDT]MtT"<e(`rn*-w$3tF&:%]KHf"{~`X*i]=gqAi,ScRRkbv&U;7Aw4WvC
X-Face-Author: David Bonde mailto:i97_bed@i.kth.se.REMOVE.THIS.TO.REPLY -- If you want to use it please also use this Authorline.
Message-ID: <slrn-0.9.7.4-26138-28832-200405011227-tc@hexane.ssi.swin.edu.au>
Date: Sat, 1 May 2004 12:36:05 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> said on Fri, 30 Apr 2004 17:38:25 -0400:
> 
> 
> Marc Boucher wrote:
> > 
> > Indeed. The driver in question contains 8 interdependent modules. What 
> > we were thinking of doing to settle the issue short-term in a fair way 
> > for both our users and kernel developers, is removing the \0 from the 
> > central one (hsfengine), causing the kernel to be properly tainted and 
> > one instance of the messages to be automatically printed when the driver 
> > is used.
> > 
> > Hopefully the community will view this as an acceptable compromise. Once 
> > patches have propagated onto people's computers, we will be happy to 
> > remove all \0's completely.
...
> I think what you need to do right now is do a lot of begging.  I agree 
> that in principle, it's only technically necessary to have one of the 
> modules taint the kernel.  But it's still "bad" to lie about the module 
> license and should only be done after much scrutiny and discussion.

What's wrong with the printk setting workaround? Simply write a number
to the appropriate file before you load the modules.

I just tried googling for the relevant post, but failed...

He doesn't need to wait for the patches to propogate. He can act on
his own scripts immediately in readiness for the next version.

Easy.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Modus Ponens in action:
- Nothing is better than world peace. 
- A turkey sandwich is better than nothing. 
  ==>  Ergo, a turkey sandwich is better than world peace. 
