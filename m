Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285632AbRL1Bbm>; Thu, 27 Dec 2001 20:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286649AbRL1Bbc>; Thu, 27 Dec 2001 20:31:32 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:47366 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285632AbRL1BbM>;
	Thu, 27 Dec 2001 20:31:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@suse.de>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 01:54:42 BST."
             <Pine.LNX.4.33.0112280147290.18346-100000@Appserv.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 12:30:54 +1100
Message-ID: <18502.1009503054@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 01:54:42 +0100 (CET), 
Dave Jones <davej@suse.de> wrote:
>On Thu, 27 Dec 2001, Eric S. Raymond wrote:
>
>> ..., and Keith's stuff is stable
>> enough that he's now adding features like kernel-image type selection
>> that were obviously way down his to-do list.
>
>How far down the list was "make it not take twice as long
>to build the kernel as kbuild 2.4" ? Keith mentioned O(n^2)
>effects due to each compile operation needing to reload
>the dependancies etc.

I had to choose between helping other architectures to convert and
rewriting the core code to speed everything up.  I chose to get other
architectures converted, finding some interesting "features" at the
same time.

The core code is stable and I will not change it right now, I want
stable code to go to Linus.  Once Linus takes kbuild 2.5 then I can
start on the rewrite, without affecting anybody else.

