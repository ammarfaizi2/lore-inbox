Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTLRIbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 03:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbTLRIbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 03:31:51 -0500
Received: from mail.mediaways.net ([193.189.224.113]:1757 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S263891AbTLRIbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 03:31:50 -0500
Subject: Re: crypto-loop + highmen -> random crashes in -test11
From: Soeren Sonnenburg <kernel@nn7.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031216034059.28db8e91.akpm@osdl.org>
References: <1071570648.3528.50.camel@localhost>
	 <20031216034059.28db8e91.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1071736227.18903.7.camel@localhost>
Mime-Version: 1.0
Date: Thu, 18 Dec 2003 09:30:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-16 at 12:40, Andrew Morton wrote:
> Soeren Sonnenburg <kernel@nn7.de> wrote:
> >
> > Hi.
> > 
> > I get random crashes/corruption/ init kills when I use cryptoloop on
> > this highmem enabled ppc machine.
> 
> People have reported cryptoloop+highmem crashes on ia32 as well.  I'm not
> sure if that was with -mm though.
> 
> > Applying the loop-* patches at
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test10/2.6.0-test10-mm1/broken-out
> > 
> > seem to fix this problem (at least I did not get any crash due to
> > cryptoloop in the last 2 days)
[...]
> Nice, but I don't know why those patches fixed it. hrm.
> 

no idea. all I can say is that it cryptoloop pretends to work reliably since 3 days...

Soeren

