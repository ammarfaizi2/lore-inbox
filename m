Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUBKPIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUBKPIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:08:32 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:57833 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265203AbUBKPIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:08:30 -0500
From: Michael Frank <mhf@linuxmail.org>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>, Michael Hayes <mike@aiinc.ca>,
       linux-kernel@vger.kernel.org
Subject: Printk message and numbers formating - was Spelling in 2.6.2
Date: Wed, 11 Feb 2004 20:43:43 +0800
User-Agent: KMail/1.5.4
References: <200402102009.i1AK91T20554@aiinc.aiinc.ca> <200402111136.03712.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200402111136.03712.vda@port.imtp.ilyichevsk.odessa.ua>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402111904.50598.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 February 2004 17:36, vda wrote:
> On Tuesday 10 February 2004 22:09, Michael Hayes wrote:
> > Relax, this is not a spelling patch.
> >
> > I was curious how fast spelling errors flow into the kernel, so I
> > looked at the + lines in the 2.6.2 patch.  A few of the errors
> > already existed, but most of them are new.  It turns out that there
> > are around 200 new spelling errors in 2.6.2.
> >
> > A "wether" (castrated goat) has appeared, along with a "Rusell" that
> > should be stamped out before it spreads.  Someone had a dreadful time
> > with "technology" and its variants, spelling it wrong 9 different ways.
> >
> > Here's what I found:
> >
> > File                                      Error            Should be       #
> 
> :))
> 
> Before all the bizzare mispels are dealed with, let me
> beg for "dont" and "cant" be pardoned. We dont enforce
> "double space after period" and "always terminate log messages
> with a period" rules, because those do no good and

Concur, pleae lets allow dont and cant.

Can we have a rule that periods terminating kernel messages 
are depreciated?

> cant lead to misinterpretations anyway.
> Dunno why, but /me thinks the same applies to donts and cants.

Just wastes space on the line, should this be depreciated?

> 
> And I just feel that ' is a string delimiter and "don't" hurts
> my eye.

Concur,

As to printing numbers, which form to use?

Should numbers in parenthesis be depreciated?

printk("Count is (%d)\n");

What about colons?

printk"Count is: %d\n");

Or just straight and simple:

printk("Count is %d\n");

Numbers in a sentence:

printk("Size %d is too big, adjusted to %d\n");
printk("Size %d is too big, adjusted to: %d\n");

Regards
Michael


