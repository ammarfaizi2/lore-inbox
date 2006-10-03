Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWJCQvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWJCQvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWJCQvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:51:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932330AbWJCQvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:51:48 -0400
Date: Tue, 3 Oct 2006 09:51:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Randy Dunlap <rdunlap@xenotime.net>
cc: akpm <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
In-Reply-To: <20061003094926.0e99d13f.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0610030950230.3952@g5.osdl.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
 <p73venk2sjw.fsf@verdi.suse.de> <9a8748490609191414m6748f2fu521637df29ef9e8e@mail.gmail.com>
 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org> <20061002191638.093fde85.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org> <20061002213809.7a3f995f.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0610030805490.3952@g5.osdl.org> <20061003092339.999d0011.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0610030933250.3952@g5.osdl.org> <20061003094926.0e99d13f.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2006, Randy Dunlap wrote:
> > 
> > So Randy, with this you can boot all the way into user space, and some FP 
> > apps still work too?
> 
> My few trivial float and double apps work.
> Is there any particular test/workload that you want me to run?

Not really, if "most things just seem to work", that's already pretty much 
all we should ask for from the math emulation.

		Linus
