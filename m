Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVHCVJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVHCVJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVHCVJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:09:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21967 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262450AbVHCVJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:09:01 -0400
Date: Wed, 3 Aug 2005 14:08:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>,
       Bodo Eggert <7eggert@gmx.de>, Gene Heskett <gene.heskett@verizon.net>,
       "H. Peter Anvin" <hpa@zytor.com>, David Brown <dmlb2000@gmail.com>,
       Puneet Vyas <vyas.puneet@gmail.com>,
       Richard Hubbell <richard.hubbell@gmail.com>, webmaster@kernel.org
Subject: Re: Documentation - how to apply patches for various trees
In-Reply-To: <200508032251.07996.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.58.0508031400390.3258@g5.osdl.org>
References: <200508022332.21380.jesper.juhl@gmail.com>
 <200508030840.39852@bilbo.math.uni-mannheim.de>
 <Pine.LNX.4.50.0508030742350.489-100000@shark.he.net>
 <200508032251.07996.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Aug 2005, Jesper Juhl wrote:
>
> Here's an updated version of my document that attempts to give a short 
> explanation of the various kernel trees and how to apply their patches.
> It incorporates all the feedback I've gotten (thanks guys). 

Can we have more whitespace?

You either have very long paragraphs, or no whitespace between them: I 
can't quite decide which one.

So leave an empty line between paragraphs (and if you already do, you need 
to split them ;) because it's very tiring to not have a nice break every 
once in the flow of text. 

Long paragraphs may be acceptable in fictional literary work that you read
without thinking about what you're reading. There you get into the "flow"  
of the text, and you hopefully don't need to have very many visual breaks
to keep as acnhor-points. However, the same is certainly not true in
technical text, especially something like this where you're trying to
explain somethign that the recipient doesn't ncessarily know.

My rule of thumb is that if you don't have a new paragraph roughly every
five or six lines, it's likely problematic. Maybe I have a shorter
attention span than most, but I don't think so - I just find it much
easier to read text that is nicely broken up, and when it's a "pure ASCII"
medium the only break that works well is an empty line (possibly with
indentation for further visual help - although in this context indentation
tends to be used for a separate issue: examples etc, and is not good for
paragraphs).

And since we have a single empty line implying paragraph breaks, feel free 
to use multiple empty lines to imply "bigger" breaks (you seem to do this 
already).

This email was written with an average paragraph length of 4 lines.

				Linus
