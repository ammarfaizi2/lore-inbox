Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUERVOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUERVOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 17:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUERVOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 17:14:19 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:15768 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263603AbUERVOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 17:14:18 -0400
Subject: Re: [patch] kill off PC9800
From: James Bottomley <James.Bottomley@steeleye.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <20040518205326.GG28735@waste.org>
References: <1084729840.10938.13.camel@mulgrave>
	<20040516142123.2fd8611b.akpm@osdl.org> <20040518201416.GT5414@waste.org>
	<40AA70B6.1050405@didntduck.org>  <20040518205326.GG28735@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 May 2004 16:14:00 -0500
Message-Id: <1084914841.1763.51.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-18 at 15:53, Matt Mackall wrote:
> Actually it's a matter of fail to attempt to compile, which is
> different than fail to compile. The principle is the same - stick
> advance notice in a highly visible place where users are likely to see
> it. That place is _not_ this mailing list.
> 
> We've had the code for years, and it would be nice to delete it if
> it's truly dead. But it seems silly to wake up one morning and say "no
> one's touched it for a year" and post a patch to delete it that same
> day. If it wasn't urgent yesterday, then why is it urgent today?

I would agree if it were a complete feature, but it's not.  PC9800
cannot be selected for compilation in the current kernel.  Without an
external patch set, it cannot be compiled or used.  As far as I can
tell, it's always been like that.

I think the best way of making someone sit up and take notice is simply
to remove it.  After all, given that we have the kernel under source
control it's not like it's going to be hard to put it back if someone
actually does notice and screams...

James


