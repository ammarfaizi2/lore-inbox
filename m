Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbUD3WFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUD3WFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUD3WFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:05:37 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:15529 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S261597AbUD3WFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:05:23 -0400
In-Reply-To: <4092C751.9060603@techsource.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <4092BB75.7050400@techsource.com> <58E313D6-9AEA-11D8-B83D-000A95BCAC26@linuxant.com> <4092C751.9060603@techsource.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <760BDA4C-9AF2-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: A compromise that could have been reached.  Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 18:05:16 -0400
To: Timothy Miller <miller@techsource.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had proposed this compromise in good faith to Rusty at the very 
beginning of the debate but have not received an answer about it from 
him yet.

Since it appears impossible to get formal "approval" from a "community" 
composed of very diverse elements (for better and for worse) we will 
probably implement this short-term solution to restore tainting.

Regards
Marc

On Apr 30, 2004, at 5:38 PM, Timothy Miller wrote:
>
> Marc Boucher wrote:
>> Indeed. The driver in question contains 8 interdependent modules. 
>> What we were thinking of doing to settle the issue short-term in a 
>> fair way for both our users and kernel developers, is removing the \0 
>> from the central one (hsfengine), causing the kernel to be properly 
>> tainted and one instance of the messages to be automatically printed 
>> when the driver is used.
>> Hopefully the community will view this as an acceptable compromise. 
>> Once patches have propagated onto people's computers, we will be 
>> happy to remove all \0's completely.
>
> At this point, you're not going to get any slack.  If this is what 
> you'd done to start with, you might have gotten away with it.  As it 
> stands, you appear to be unwilling to comply with the rules, except as 
> a last resort when you've been flamed for days.
>
> I think what you need to do right now is do a lot of begging.  I agree 
> that in principle, it's only technically necessary to have one of the 
> modules taint the kernel.  But it's still "bad" to lie about the 
> module license and should only be done after much scrutiny and 
> discussion.
>
> So if everyone who has a stake in this agrees to let you do it, then 
> go ahead.  Otherwise, sorry Charley, but you're SOL.
>

