Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265258AbUD3U16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUD3U16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUD3U16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:27:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:8075 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265261AbUD3U10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:27:26 -0400
Date: Fri, 30 Apr 2004 13:26:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Boucher <marc@linuxant.com>
cc: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.58.0404301319020.18014@ppc970.osdl.org>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
 <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
 <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Apr 2004, Marc Boucher wrote:
>
> > In contrast, wine was _written_ to do this emulation, so by definition 
> > any
> > "bugs" are in wine itself (although I suspect that wine people 
> > sometimes
> > would prefer it if Office came with sources ;).
> 
> The same can be said about DriverLoader.

.. but not abotu the kernel that it depends on.

In other words, if driverloader was a stand-alone project, you could do 
whatever the hell you wanted with it.

But it isn't a standalone project, is it? It depends on the kernel, and 
there is no question that driverloader is a derived work.

Which means that you had better follow the rules.

So stop yer whining. When you write your own operating system, and your 
driver doesn't have to depend on anybody elses code, then you can set the 
rules. As it is, the kernel requires modules to tell it their license, and 
if you lie to it, that is not only potentially violating the DMCA, it's 
also likely a crime under regular copyright laws (ie you are knowingly 
misrepresenting a license - in this case the license of the binary part, 
and that's not legal either).

> The purpose of the workaround is not to circumvent any protection, but 
> to fix a real usability issue for systems in the field, which, as an 
> expert you perhaps do not see, but users definitely massively felt and 
> complained about.

Oh, so it's ok to do something illegal, because it helps usability? And 
ethics take second place to "the user doesn't want to see that line in the 
logs"?

Sure, that's a good argument. NOT.

GET RID OF YOUR LYING LICENSE LINE!

		Linus
