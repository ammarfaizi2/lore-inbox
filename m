Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269422AbUJLDrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269422AbUJLDrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 23:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269425AbUJLDrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 23:47:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:37563 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269422AbUJLDrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 23:47:19 -0400
Date: Mon, 11 Oct 2004 20:45:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Cc: roland@redhat.com, joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-Id: <20041011204512.6c67333c.akpm@osdl.org>
In-Reply-To: <20041012033934.GA275@elektroni.ee.tut.fi>
References: <20041010211507.GB3316@triplehelix.org>
	<200410112055.i9BKt5LI031359@magilla.sf.frob.com>
	<20041012033934.GA275@elektroni.ee.tut.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
>
> On Mon, Oct 11, 2004 at 01:55:05PM -0700, Roland McGrath wrote:
> > > wait4(-1073750280, NULL, 0, NULL)       = -1 ECHILD (No child processes)
> > 
> > That is a clearly bogus argument.
> 
> Hi. I see it too:
> 
> wait4(-1073750328, NULL, 0, NULL)       = -1 ECHILD (No child processes)
> 
> But the whole problem goes away if I switch CONFIG_REGPARM off. To reproduce
> it needs CONFIG_REGPARM=y.
> 

Interesting.

What command are you actually running to demonstrate this?  Full details,
please.

