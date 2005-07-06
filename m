Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVGFPvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVGFPvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 11:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVGFPvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 11:51:46 -0400
Received: from [203.171.93.254] ([203.171.93.254]:48547 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262263AbVGFLkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 07:40:05 -0400
Subject: Re: [PATCH] [26/48] Suspend2 2.1.9.8 for 2.6.12:
	603-suspend2_common-headers.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f0205070603223790e4df@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164424053@foobar.com>
	 <84144f0205070603223790e4df@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120650075.4860.212.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 21:41:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 20:22, Pekka Enberg wrote:
> > diff -ruNp 604-utility-header.patch-old/kernel/power/suspend2_core/utility.h 604-utility-header.patch-new/kernel/power/suspend2_core/utility.h
> > --- 604-utility-header.patch-old/kernel/power/suspend2_core/utility.h   1970-01-01 10:00:00.000000000 +1000
> > +++ 604-utility-header.patch-new/kernel/power/suspend2_core/utility.h   2005-07-05 23:48:59.000000000 +1000
> 
> Please do move these.

Okay.

> > +
> > +extern int suspend_snprintf(char * buffer, int buffer_size, const char *fmt, ...);
> 
> What's wrong with regular snprintf?

If there's a buffer overrun, it returns the number of bytes it wanted to
use, not the number actually used.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

