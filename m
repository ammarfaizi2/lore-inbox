Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVGFQ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVGFQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVGFQXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:23:19 -0400
Received: from [203.171.93.254] ([203.171.93.254]:60836 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262187AbVGFME1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:04:27 -0400
Subject: Re: [PATCH] [32/48] Suspend2 2.1.9.8 for 2.6.12:
	609-driver-model.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f0205070603102167e721@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164423660@foobar.com>
	 <84144f0205070603102167e721@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120651542.4860.242.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 22:05:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 20:10, Pekka Enberg wrote:
> On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> > diff -ruNp 610-encryption.patch-old/kernel/power/suspend2_core/encryption.c 610-encryption.patch-new/kernel/power/suspend2_core/encryption.c
> > --- 610-encryption.patch-old/kernel/power/suspend2_core/encryption.c    1970-01-01 10:00:00.000000000 +1000
> > +++ 610-encryption.patch-new/kernel/power/suspend2_core/encryption.c    2005-07-05 23:54:31.000000000 +1000
> > +static inline void free_local_buffer(void)
> > +{
> > +       if (page_buffer)
> > +               free_pages((unsigned long) page_buffer, 0);
> 
> Use free_page(), please.

Done. Thanks!

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

