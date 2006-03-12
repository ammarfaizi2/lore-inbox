Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWCLJFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWCLJFa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 04:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWCLJFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 04:05:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18386 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751228AbWCLJF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 04:05:29 -0500
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
From: Arjan van de Ven <arjan@infradead.org>
To: psycho@rift.ath.cx
Cc: linux-kernel@vger.kernel.org,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>
In-Reply-To: <20060312000621.GA8911@nexon>
References: <20060312000621.GA8911@nexon>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 10:05:22 +0100
Message-Id: <1142154323.2882.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 01:06 +0100, Patrick =?utf-8?Q?B=F6rjesson?=
wrote:
> > Just to let you know, I've had the same problem on x86-64. It's an
> > incredibly rare fault here and I've not been able to reproduce it.
> > However, I cannot help but notice that all of the reporters so far
> > have been running the binary NVIDIA driver, including myself.
> > 
> > I would not be surprised if running without the NVIDIA driver
> > eliminated the problem.
> 
> Not running either with the NVIDIA driver or with x86-64 on the machine
> I'm getting this on, but I get it fairly often (as in: today I've
> probably gotten it at least 5-10 times). It seems it's pretty bound by
> either high CPU or disk usage, since I've always gotten it while
> compiling stuff so far. Although my system doesn't hard lock if I get
> this error; I can at least run most commands and ssh into it.


just to rule the last issue out: this machine survives memtest86 ?


