Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283752AbRK3S3b>; Fri, 30 Nov 2001 13:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283747AbRK3S3V>; Fri, 30 Nov 2001 13:29:21 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:39172 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283744AbRK3S3R>; Fri, 30 Nov 2001 13:29:17 -0500
Date: Fri, 30 Nov 2001 10:39:46 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Simon Turvey <turveysp@ntlworld.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Generating a function call trace
In-Reply-To: <3C07CDF9.F1069C71@didntduck.org>
Message-ID: <Pine.LNX.4.40.0111301035490.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Brian Gerst wrote:

> Davide Libenzi wrote:
> >
> > On Fri, 30 Nov 2001, Simon Turvey wrote:
> >
> > > Is it possible to arbitrarily generate (in a module say) a function call
> > > trace?
> >
> > gcc has builtin macros to trace back or ( on x86 ) you can simply chain
> > through %esp/%ebp
>
> That only works if you compile with frame pointers, which the kernel
> turns off for performance reasons (due to register pressure on the x86).

I thought it was a general question not a kernel code one.
Sure -fomit-frame-pointer is on inside the kernel.




- Davide


