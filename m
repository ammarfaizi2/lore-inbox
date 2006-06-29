Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWF2U5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWF2U5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWF2U5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:57:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932544AbWF2U5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:57:06 -0400
Date: Thu, 29 Jun 2006 14:00:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm one process gets stuck in infinite loop in the
 kernel.
Message-Id: <20060629140024.57d94629.akpm@osdl.org>
In-Reply-To: <20060629203942.GE20456@charite.de>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<44A3B8A0.4070601@aitel.hist.no>
	<20060629104117.e96df3da.akpm@osdl.org>
	<20060629203942.GE20456@charite.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> wrote:
>
> * Andrew Morton <akpm@osdl.org>:
> 
> > > I have seen this both with mm2, m33 and mm4.
> > > Suddenly, the load meter jumps.
> > > Using ps & top, I see one process using 100% cpu.
> > > This is always a process that was exiting, this tend to happen
> > > when I close applications, or doing debian upgrades which
> > > runs lots of short-lived processes.
> > > 
> > > I believe it is running in the kernel, ps lists it with stat "RN"
> > > and it cannot be killed, not even with kill -9 from root.
> 
> I see exactly the same here.
> 
> > Please generate a kernel profile when it happens so we can see
> > where it got stuck.
> 
> Do I need to compile the kernel with profiling for this:> 

Nope.

> > <boot with profile=1>
> to work? And is "profile=1" a boot parameter?

Yes, profile=1 is a boot parameter.
