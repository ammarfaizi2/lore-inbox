Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283748AbRK3SWl>; Fri, 30 Nov 2001 13:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283738AbRK3SWa>; Fri, 30 Nov 2001 13:22:30 -0500
Received: from quark.didntduck.org ([216.43.55.190]:21767 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S283748AbRK3SUu>; Fri, 30 Nov 2001 13:20:50 -0500
Message-ID: <3C07CDF9.F1069C71@didntduck.org>
Date: Fri, 30 Nov 2001 13:20:41 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Simon Turvey <turveysp@ntlworld.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Generating a function call trace
In-Reply-To: <Pine.LNX.4.40.0111300900050.1600-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Fri, 30 Nov 2001, Simon Turvey wrote:
> 
> > Is it possible to arbitrarily generate (in a module say) a function call
> > trace?
> 
> gcc has builtin macros to trace back or ( on x86 ) you can simply chain
> through %esp/%ebp

That only works if you compile with frame pointers, which the kernel
turns off for performance reasons (due to register pressure on the x86).

--

				Brian Gerst
