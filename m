Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263216AbSJVPs7>; Tue, 22 Oct 2002 11:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSJVPs7>; Tue, 22 Oct 2002 11:48:59 -0400
Received: from 62-190-203-199.pdu.pipex.net ([62.190.203.199]:9997 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263216AbSJVPs6>; Tue, 22 Oct 2002 11:48:58 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210221604.g9MG4Ew7002137@darkstar.example.net>
Subject: Re: running 2.4.2 kernel under 4MB Ram
To: amolk@ishoni.com (Amol Kumar Lad)
Date: Tue, 22 Oct 2002 17:04:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1035333109.2200.2.camel@amol.in.ishoni.com> from "Amol Kumar Lad" at Oct 22, 2002 08:31:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2002-10-22 at 06:06, Alan Cox wrote:
> > On Tue, 2002-10-22 at 19:54, Amol Kumar Lad wrote:
> > > Hi,
> > >  I want to run 2.4.2 kernel on my embedded system that has only 4 Mb
> > > SDRAM . Is it possible ?? Is there any constraint for the minimum
> > SDRAM
> > > requirement for linux 2.4.2
> > 
> > You want to run something a lot newer than 2.4.2. 2.4.19 will run on a
> > 4Mb box, and with Rik's rmap vm seems to be run better than 2.2. That
> > will depend on the workload.
> 
> It means that I _cannot_ run 2.4.2 on a 4MB box. 
> Actually my embedded system already has 2.4.2 running on a 16Mb. I was
> looking for a way to run it in 4Mb. 
> So Is upgrade to 2.4.19 the only option ??

You _should_ be able to run 2.4.2 in 4Mb, but as Alan pointed out,
there is no reason to stick with that old version just because of lack
of memory.  Exactly what problems are you having running 2.4.2 in 4Mb
anyway?  By the way, I am assuming that your embedded system is X86
based.  I have run all of the kernels I mentioned in my previous post
in swapless_ 4Mb on X86.

John.
