Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRJRSkB>; Thu, 18 Oct 2001 14:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277951AbRJRSjw>; Thu, 18 Oct 2001 14:39:52 -0400
Received: from doorbell.lineo.com ([204.246.147.253]:49907 "EHLO
	thor.lineo.com") by vger.kernel.org with ESMTP id <S277949AbRJRSjp>;
	Thu, 18 Oct 2001 14:39:45 -0400
Message-ID: <3BCF22AD.2ED72872@lineo.com>
Date: Thu, 18 Oct 2001 12:42:53 -0600
From: Tim Bird <tbird@lineo.com>
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
In-Reply-To: <3bcef893.4872.0@panix.com> <20011018114921.A30969@devserv.devel.redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> On Thu, Oct 18, 2001 at 11:43:15AM -0500, Roy Murphy wrote:
> > With all respect to Linus, I don't believe that module insertion is an
> > exclusive right granted to authors that is within Linus' legal power as holder
> > of the Copyright to the kernel to grant or to restrict.  Does Microsoft have
> > a legal right to disallow any third-party drivers from
> > registering themselves with the OS?  Does Linus?
> 
> I'm sorry. "module inserting" is LINKING. A kernel module does, in my
> oppinion, NOT fall under the gpl stated "mere aggregation" boundary of the
> GPL, it is compiled with kernel headers, contains kernel _code_ from these
> headers etc etc, and is for all intents and purposes part of the GPL program
> "kernel" once loaded. It uses normal function calls etc etc, symbols are
> resolved using normal linking mechanisms etc etc.

"module inserting is linking" is true for almost
any other operating system which supports loadable modules
(including Windows), and really has no bearing on Mr. Murphy's 
argument.  The stronger argument is with the kernel header
files being GPL, to the degree that they contain macros
containing actual code, which expand into binary code
actually in the compiled module.

However, Mr. Murphy's point is correct.  The law
supports the idea that certain INTERFACES may create
a legitimate boundary between different code bases
to distinguish them (as not being derivative works
of each other).  This is true no matter what the FSF
thinks of static linking vs. dyamic linking, or what
Linus has said about permissibility of non-GPL
loadable modules.
I don't think even the interface creator can decide
whether a particular interface meets the criteria for
isolating or not the calling program from being a derivative
work. It's really up to a judge.

However, the EXPORT_SYMBOL_GPL facility may play a
role in indicating to a judge or jury the intent of the
original developer with regard to the interface.  This
is unlikely to have as big an impact on the legality
of using the symbol from a non-GPL module as other factors
that come into play here.

Please don't misinterpret me.  I'm glad Linus made his
exception (even though it may not exactly jibe with
copyright law and the GPL license), and I see value
in having developer's express their licensing intent
for their published interfaces.  It's just dangerous
to assume this holds much legal weight.

____________________________________________________________
Tim Bird                                  Lineo, Inc.
Senior VP, Research                       390 South 400 West
tbird@lineo.com                           Lindon, UT 84042
