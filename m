Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263143AbVGaAWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbVGaAWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbVGaAWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:22:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5068 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263143AbVGaAVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:21:31 -0400
Subject: Re: Simple question re: oops
From: Lee Revell <rlrevell@joe-job.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050731001101.GA6762@localhost.localdomain>
References: <1122767292.4464.1.camel@mindpipe>
	 <20050731001101.GA6762@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 20:21:29 -0400
Message-Id: <1122769290.4464.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 02:11 +0200, Alexander Nyberg wrote:
> On Sat, Jul 30, 2005 at 07:48:11PM -0400 Lee Revell wrote:
> 
> > I have a machine here that oopses reliably when I start X, but the
> > interesting stuff scrolls away too fast, and a bunch more Oopses get
> > printed ending with "Aieee, killing interrupt handler".
> > 
> > How do I get the output to stop after the first Oops?
> > 
> 
> set /proc/sys/kernel/panic_on_oops to 1
> 
> What version of the kernel is that? It shouldn't do recursive oopses
> (of the same task) any more.
> 

panic_on_oops has no effect, a bunch of stuff flies past and the last
thing I see is "gam_server: scheduling while atomic" then a stack trace
of the core dump path then "Aiee, killing interrupt handler".

I am starting to suspect the hard drive, does that sound plausible?
It's as if it locks up when it hits a certain disk block.

Lee

