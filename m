Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSGKEEV>; Thu, 11 Jul 2002 00:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317756AbSGKEEV>; Thu, 11 Jul 2002 00:04:21 -0400
Received: from [202.135.142.194] ([202.135.142.194]:35333 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317755AbSGKEET>; Thu, 11 Jul 2002 00:04:19 -0400
Date: Thu, 11 Jul 2002 14:11:35 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: afu@fugmann.dhs.org, linux-kernel@vger.kernel.org, ricklind@us.ibm.com
Subject: Re: Chatserver workload simulator by Bill Hartner?
Message-Id: <20020711141135.6fab3406.rusty@rustcorp.com.au>
In-Reply-To: <3D2B0F0C.5050108@us.ibm.com>
References: <3D2AA82C.7030305@fugmann.dhs.org>
	<3D2B0F0C.5050108@us.ibm.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jul 2002 09:27:56 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> Anders Fugmann wrote:
> > I'm looking for the chatserver workload simulator made by Bill hartner, 
> > which was used to test the O(1) scheduler by Ingo Molnar.
> > 
> > Does anyone know where to find it? - All I can find is the VolanoMark,
> > but I guess that this is not the one used, since the command used by 
> > Ingo Molnar when benchmarking the O(1) scheduler is: './chat_c 127.0.0.1 
> > 10 100'.
> 
> Volanomark is probably the one, although I didn't know that Bill 
> Hartner made it.  It is one of the benchmarks that we use quite a bit.
> 
> BTW, why didn't you ask Bill Hartner?

Hmm, I wrote an even more cut-down one called hackbench (I really should have
called it schedbench).  Basically, if you can do well on this, you should
do well on Volanomark, since at the core it's the same scheduler-stressing
load.  Look for the linearity of "hackbench 10" to "hackbench 100".

Google is your friend,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
