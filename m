Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUD3Vdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUD3Vdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUD3Vdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:33:38 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:32275 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261179AbUD3Vdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:33:36 -0400
Message-ID: <4092C751.9060603@techsource.com>
Date: Fri, 30 Apr 2004 17:38:25 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: Re: A compromise that could have been reached.  Re: [PATCH] Blacklist
 binary-only modules lying about their license
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <4092BB75.7050400@techsource.com> <58E313D6-9AEA-11D8-B83D-000A95BCAC26@linuxant.com>
In-Reply-To: <58E313D6-9AEA-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Boucher wrote:
> 
> Indeed. The driver in question contains 8 interdependent modules. What 
> we were thinking of doing to settle the issue short-term in a fair way 
> for both our users and kernel developers, is removing the \0 from the 
> central one (hsfengine), causing the kernel to be properly tainted and 
> one instance of the messages to be automatically printed when the driver 
> is used.
> 
> Hopefully the community will view this as an acceptable compromise. Once 
> patches have propagated onto people's computers, we will be happy to 
> remove all \0's completely.
> 

At this point, you're not going to get any slack.  If this is what you'd 
done to start with, you might have gotten away with it.  As it stands, 
you appear to be unwilling to comply with the rules, except as a last 
resort when you've been flamed for days.

I think what you need to do right now is do a lot of begging.  I agree 
that in principle, it's only technically necessary to have one of the 
modules taint the kernel.  But it's still "bad" to lie about the module 
license and should only be done after much scrutiny and discussion.

So if everyone who has a stake in this agrees to let you do it, then go 
ahead.  Otherwise, sorry Charley, but you're SOL.

