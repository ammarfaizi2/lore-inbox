Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290498AbSAYCBP>; Thu, 24 Jan 2002 21:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290497AbSAYCBF>; Thu, 24 Jan 2002 21:01:05 -0500
Received: from codepoet.org ([166.70.14.212]:34022 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S290495AbSAYCAL>;
	Thu, 24 Jan 2002 21:00:11 -0500
Date: Thu, 24 Jan 2002 19:00:13 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020125020013.GA12506@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 24, 2002 at 12:42:58PM -0500, Jeff Garzik wrote:
> A small issue... 
> 
> C99 introduced _Bool as a builtin type.  The gcc patch for it went into
> cvs around Dec 2000.  Any objections to propagating this type and usage
> of 'true' and 'false' around the kernel?
> 
> Where variables are truly boolean use of a bool type makes the
> intentions of the code more clear.  And it also gives the compiler a
> slightly better chance to optimize code [I suspect].
> 
> Actually I prefer 'bool' to '_Bool', if this becomes a kernel standard.

Agreed, bool is nicer.  Out of curiosity, esp 
wrt struct packing, how does gcc actully store 
a bool?  A single bit?  A full 32-bit word?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
