Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSFJFhC>; Mon, 10 Jun 2002 01:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSFJFhB>; Mon, 10 Jun 2002 01:37:01 -0400
Received: from violet.setuza.cz ([194.149.118.97]:53258 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S316672AbSFJFhB>;
	Mon, 10 Jun 2002 01:37:01 -0400
Subject: Re: kernel serial debugging question
From: Frank Schaefer <frank.schafer@setuza.cz>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020607231856Z317361-22020+731@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Jun 2002 07:37:02 +0200
Message-Id: <1023687422.250.0.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-08 at 01:18, Stephane Charette wrote:
> My question:
> ------------
> 
> Has any of this changed with the 2.4.x kernel?  I'm currently playing
> with 2.4.19-pre9.  Is there a "serial debugger" patch that has to be
> applied first, or is this support normally built-in?

I've set up kernel remote debugging for 2.4.18 not so far ago. The
procedure is the same as for the 2.2.* series. You should simply use the
patch for the kernel version you use.

> The reason I ask is because I don't see the option "Kernel support for
> GDB", which leads me to think that maybe this functionality actually
> came from a patch that was applied on top of 2.2.14.
> 
> While I'm at it:  is there a "better", or perhaps a "more popular"
> method of debugging the kernel?

On my development machine I've set up one kernel with the kgdb internal
debugger, one kernel with the gdb-patch and one unpatched kernel with
the usual debugging stuff enabled ( all kernels of the same version - of
course ). Which kernel to run depends on the kind of problem to solve,
and is IMHO more a question of personal taste.

Regards
Frank


