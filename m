Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311905AbSCOByc>; Thu, 14 Mar 2002 20:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311904AbSCOByM>; Thu, 14 Mar 2002 20:54:12 -0500
Received: from zero.tech9.net ([209.61.188.187]:13583 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311903AbSCOByE>;
	Thu, 14 Mar 2002 20:54:04 -0500
Subject: Re: 2.4.18 Preempt Freezeups
From: Robert Love <rml@tech9.net>
To: Ian Duggan <ian@ianduggan.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9153A7.292C320@ianduggan.net>
In-Reply-To: <3C9153A7.292C320@ianduggan.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 14 Mar 2002 20:54:09 -0500
Message-Id: <1016157250.4599.62.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-14 at 20:51, Ian Duggan wrote:

> Stock 2.4.17+preempt+lock-break+mki-adapter+win4lin
> 
> 	- Problem extremely intermittent, maybe once a day.
> 
> 
> Stock 2.4.18+preempt+mki-adapter+win4lin
> 
> 	- Very frequent, and also repeatable every time I
> 		try to start win4lin.

Pretty clear it is win4line.  Is it SMP-safe?

Is there another kernel module you load for win4lin?  Binary?  It needs
to be made preempt (and SMP) -safe.

	Robert Love


