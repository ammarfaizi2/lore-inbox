Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUBVDHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUBVDHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:07:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:24031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261650AbUBVDHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:07:10 -0500
Date: Sat, 21 Feb 2004 19:12:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
In-Reply-To: <20040222025957.GA31813@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
 <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org>
 <20040222025957.GA31813@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Feb 2004, Herbert Poetzl wrote:
> 
> hmm, so the current x86_64 will be changed to x86-64 or
> will there be x86_64 and x86-64?

No. The filesystem policy _tends_ to be that dashes and spaces are turned 
into underscores when used as filenames. Don't ask me why (well, the space 
part is obvious, since real spaces tend to be a pain to use on the command 
line, but don't ask me why people tend to conver a dash to an underscore).

So the real name is (and has always been, as far as I can tell) x86-64. 

Actually, I'm a bit disgusted at Intel for not even _mentioning_ AMD in 
their documentation or their releases, so I'd almost be inclined to rename 
the thing as "AMD64" just to give credit where credit is due. However, 
it's just not worth the pain and confusion.

Any Intel people on this list: tell your managers to be f*cking ashamed of
themselves. Just because Intel didn't care about their customers and has
been playing with some other 64-bit architecture that nobody wanted to use
is no excuse for not giving credit to AMD for what they did with x86-64.

(I'm really happy Intel finally got with the program, but it's pretty 
petty to not even mention AMD in the documentation and try to make it 
look like it was all their idea).

		Linus
