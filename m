Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbULBGjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbULBGjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 01:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbULBGjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 01:39:09 -0500
Received: from [81.23.229.73] ([81.23.229.73]:33191 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261559AbULBGjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 01:39:07 -0500
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
Date: Thu, 2 Dec 2004 07:39:04 +0100
User-Agent: KMail/1.6.2
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>
In-Reply-To: <20041202044034.GA8602@thunk.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412020739.04599.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 December 2004 05:40, Theodore Ts'o wrote:
> On Thu, Dec 02, 2004 at 05:34:08AM +0530, Imanpreet Singh Arora wrote:
> >    I realize most of the unhappiness lies with C++ compilers being
> > slow. Also the fact that a lot of Hackers around here are a lot more
> > familiar with C, rather than C++. However other than that what are the
> > _implementation_  issues that you hackers might need to consider if it
> > were to be implemented in C++.
>
> The suckitude of C++ compilers is only part of the issues.
>
> > My question is regarding how will kernel
> > deal with C++ doing too much behind the back, Calling constructors,
> > templates exceptions and other. What are the possible issues of such an
> > approach while writing device drivers?  What sort of modifications do
> > you reckon might be needed if such a move were to be made?
>
> The way the kernel will deal with C++ language being a complete
> disaster (where something as simple as "a = b + c + d +e" could
> involve a dozen or more memory allocations, implicit type conversions,
> and overloaded operators) is to not use it.  Think about the words of
> wisdom from the movie Wargames: "The only way to win is not to play
> the game".

Let us do it all in assembler. Real optimization for every CPU.

BTW, that sparks a question: 
Did anybody already do a benchmark to see what happens if you address an AMD 
cpu not with x86 instructions but with it's native code, so to circumvent the 
internal translation in the CPU?


>
> 					- Ted
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
