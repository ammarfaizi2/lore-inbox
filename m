Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUAESkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUAESkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:40:22 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:47881 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265298AbUAESkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:40:17 -0500
Date: Mon, 5 Jan 2004 19:40:13 +0100
From: Willy Tarreau <willy@w.ods.org>
To: midian@ihme.org
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.24 released
Message-ID: <20040105184013.GB2550@alpha.home.local>
References: <200401051355.i05DtvgC020415@hera.kernel.org> <1073321792.21338.2.camel@midux> <20040105171843.GA2407@alpha.home.local> <1073324505.21338.11.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073324505.21338.11.camel@midux>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 07:41:45PM +0200, Markus H?stbacka wrote:
> On Mon, 2004-01-05 at 19:18, Willy Tarreau wrote:
> > Compiled correctly here. Are you sure your patch applied correctly ?
> > Care to post .config ?
> > 
> I didn't use patch, I downloaded the full sources.
> Sure, config attached below. NOTE: it has grsecurity things in it but I
> tested without grsecurity too, same results.

strange, it still works flawlessly here with your .config :

egrep 'dummy|shaper' /tmp/test/lib/modules/2.4.24/modules.dep 
/lib/modules/2.4.24/kernel/drivers/net/dummy.o:
/lib/modules/2.4.24/kernel/drivers/net/shaper.o:

I have depmod 2.4.22i, gcc 2.95.3, ld 2.12.1 if this can help.
Have you tried without modules versionning ?

Willy

