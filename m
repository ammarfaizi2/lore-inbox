Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUDQAcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbUDQAcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:32:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:40592 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262774AbUDQAcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:32:21 -0400
Subject: Re: radeonfb broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timothy Miller <miller@techsource.com>
Cc: Felix von Leitner <felix-kernel@fefe.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4080029C.4000308@techsource.com>
References: <20040415202523.GA17316@codeblau.de>
	 <407EFB08.6050307@techsource.com> <1082079792.2499.229.camel@gaston>
	 <4080029C.4000308@techsource.com>
Content-Type: text/plain
Message-Id: <1082161356.2499.298.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 10:22:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 01:58, Timothy Miller wrote:
> Benjamin Herrenschmidt wrote:
> >>What annoys me most about the Radeon driver is the off-by-one error in 
> >>the bmove routine.  Whenever text is copied to the right or down, it 
> >>gets positioned incorrectly.  I posted the fix, but no one paid attention.
> > 
> > 
> > Mayb it was just "missed" in the flow of hundreds of mails that go
> > through this list. Can you re-sent it to me, and also precise which
> > kernel version it applies to ?
> >
> 
> Oh, I failed to mention this bit.
> 
> I've seen it in 2.4.22-gentoo-r7 and 2.4.25-gentoo.
> 
> The bug is NOT present in Red Hat's 2.4.18-27.7.x

Can you send me the fix you posted back then ?

Ben.


