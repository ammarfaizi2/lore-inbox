Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbRFUSfI>; Thu, 21 Jun 2001 14:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbRFUSe6>; Thu, 21 Jun 2001 14:34:58 -0400
Received: from intranet.resilience.com ([209.245.157.33]:28819 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S265094AbRFUSet>; Thu, 21 Jun 2001 14:34:49 -0400
Message-ID: <3B323F51.BEDC7712@resilience.com>
Date: Thu, 21 Jun 2001 11:39:13 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> ------------------------------------------------------------------------
> The GPL license reproduced below is copyrighted by the Free Software
> Foundation, but the Linux kernel is copyrighted by me and others who
> actually wrote it.
> 
> The GPL license requires that derivative works of the Linux kernel
> also fall under GPL terms, including the requirement to disclose
> source.  The meaning of "derivative work" has been well established
> for traditional media, and those precedents can be applied to
> inclusion of source code in a straightforward way.  But as of
> mid-2001, neither case nor statute law has yet settled under what
> circumstances *binary* linkage of code to a kernel makes that code a
> derivative work of the kernel.
> 
> To calm down the lawyers, I as the principal kernel maintainer and
> anthology copyright holder on the code am therefore adding the
> following interpretations to the kernel license:
> 
> 1. Userland programs which request kernel services via normal system
>    calls *are not* to be considered derivative works of the kernel.
> 
> 2. A driver or other kernel component which is statically linked to
>    the kernel *is* to be considered a derivative work.
> 
> 3. A kernel module loaded at runtime, after kernel build, *is not*
>    to be considered a derivative work.
> 
> These terms are to be considered part of the kernel license, applying
> to all code included in the kernel distribution.  They define your
> rights to use the code in *this* distribution, however any future court
> may rule on the underlying legal question and regardless of how the
> license or interpretations attached to future distributions may change.

I disagree with 2.  Consider the following:

- GPL library foo is used by application bar.  bar must be GPL because
foo is.  I agree with this.
- Non-GPL library foo is used by GPL application bar.  foo does NOT
become GPL just because bar is, even if bar statically linked foo in.

The kernel is the equivalent of an application.  If someone needs to
statically link in a driver, which is the equivalent of a library, I
don't see how that should make the driver GPL.


-Jeff

P.S.  I don't claim to be a lawyer, this is just my opinion.

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
