Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSFCEIn>; Mon, 3 Jun 2002 00:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317265AbSFCEIm>; Mon, 3 Jun 2002 00:08:42 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:49137 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317264AbSFCEIl>; Mon, 3 Jun 2002 00:08:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make balance_classzone() use list.h 
In-Reply-To: Your message of "Sun, 02 Jun 2002 16:13:12 MST."
             <20020602231312.GR14918@holomorphy.com> 
Date: Mon, 03 Jun 2002 14:11:30 +1000
Message-Id: <E17EjBq-0004GG-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020602231312.GR14918@holomorphy.com> you write:
> balance_classzone() does a number of open-coded list operations. This
> adjusts balance_classzone() to use generic list.h operations as well
> as renaming __freed and restructuring some of the control flow to use
> if (unlikely(...))) goto handle_rare_case; for additional conciseness
> and reducing the number of indentation levels required.
> 
> Against 2.5.19

No, it seems to be against 2.5.19+some of your previous patches.

The trivial patch system (almost by definition) does not handle
interdependent patches, sorry. 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
