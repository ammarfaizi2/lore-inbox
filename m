Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293344AbSCJWMa>; Sun, 10 Mar 2002 17:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293342AbSCJWMP>; Sun, 10 Mar 2002 17:12:15 -0500
Received: from zero.tech9.net ([209.61.188.187]:21258 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293343AbSCJWMB>;
	Sun, 10 Mar 2002 17:12:01 -0500
Subject: Re: [PATCH] syscall interface for cpu affinity
From: Robert Love <rml@tech9.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020310220557.GA12383@tapu.f00f.org>
In-Reply-To: <1015784104.1261.8.camel@phantasy> 
	<20020310220557.GA12383@tapu.f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 10 Mar 2002 17:11:28 -0500
Message-Id: <1015798309.928.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-10 at 17:05, Chris Wedgwood wrote:

> Can't wer just copy the IRIX interface here as some other pathces have
> in the past?

Is that psets?  If so, no thanks.

I want a simple, clean, quick implementation.  I have seen patches that
do a lot more than what my simple implementation does, and that really
does not interest me and I suspect Ingo and others feel the same way. 
Setting a simple per-task bitmask that is inherited is all we need.

Linux scheduler API is already our own standard.  I'd rather support
that (i.e. add another simple sched_* call) than some evil other
interface - but that is just me.

	Robert Love

