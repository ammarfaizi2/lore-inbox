Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVIMTLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVIMTLV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVIMTLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:11:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965136AbVIMTLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:11:17 -0400
Date: Tue, 13 Sep 2005 12:11:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mathieu Fluhr <mfluhr@nero.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <1126635160.2183.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509131210090.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> 
 <1126608030.3455.23.camel@localhost.localdomain>  <1126630878.2066.6.camel@localhost.localdomain>
  <Pine.LNX.4.58.0509131010010.3351@g5.osdl.org> <1126635160.2183.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Mathieu Fluhr wrote:
> 
> Okay, here is the point: I will have these bloody buffer underruns
> unless I select a 'Timer frequency' of 1000 Hz in 'Processor type and
> features' section of the kernel configuration. That's quite
> understandable, as recording a DVD at 16x requires a throughput of 22160
> KB/s, which is quite fast.
> 
> I will have a deep look in the patch, and maybe write a patched patch
> (Ooooo my god what am I writing ?) in the next few days.

It may just be an application bug too. Too small a buffer, and depending 
on 2.6.x with a 1kHz timer having timers that run faster...

		Linus
