Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUD3TUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUD3TUo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265231AbUD3TUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:20:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:31946 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265229AbUD3TUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:20:41 -0400
Date: Fri, 30 Apr 2004 12:19:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hua Zhong <hzhong@cisco.com>
cc: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>,
       "'Marc Boucher'" <marc@linuxant.com>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Timothy Miller'" <miller@techsource.com>, koke@sindominio.net,
       "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: RE: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
Message-ID: <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Apr 2004, Hua Zhong wrote:
> 
> I have not heard so much WINING about WINE. I even see kernel developers add
> more support in the kernel to support WINE. Why do people like to pick on
> closed-source drivers being run by a wrapper? I see nothing wrong with that.

What is so hard to understand about the problem with bugs?

All software has bugs. Binary modules just mean that those bugs are
 - FATAL to the system, including possibly being a huge security hole.
 - impossible to debug
 - impossible to fix

In contrast, wine was _written_ to do this emulation, so by definition any
"bugs" are in wine itself (although I suspect that wine people sometimes
would prefer it if Office came with sources ;).

> Linuxant did a wrong thing by working around the warning message, but I
> don't think it's fair to accuse of their business because they allow binary
> drivers run on Linux.

Nobody has sued them over copyright infringement. What they are doing is 
likely legal - APART from the fact that they lied about the license, which 
is not only horribly immoral, it's also likely illegal under the DMCA.

Note: to me, the immoral part is the big one. If you want to flaunt the
DMCA and take the risk of the feds coming after you as a matter of civil
disobedience, all the more power to you. Let's not be hypocritical and
claim to like the DMCA.

But let's not kid about this: adding that '\0' thing to try to make the
kernel believe it was GPL'd code is not ethical, and there is no way to
claim that it's needed, since the _only_ thing it suppresses are a few
messages saying that the kernel is tainted as a result. Which it IS.

So don't bother trying to stand up for Linuxant. What they did was WRONG,
and there are no excuses for it. And I hope that they have it fixed
already and we can hereby just forget about this discussion.

		Linus
