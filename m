Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTABPbq>; Thu, 2 Jan 2003 10:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTABPbp>; Thu, 2 Jan 2003 10:31:45 -0500
Received: from mail.gmx.net ([213.165.65.60]:7100 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262190AbTABPbp>;
	Thu, 2 Jan 2003 10:31:45 -0500
Date: Thu, 2 Jan 2003 16:40:10 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power off a SMP Box
Message-Id: <20030102164010.5114287b.gigerstyle@gmx.ch>
In-Reply-To: <20030103020358.2c0e6714.sfr@canb.auug.org.au>
References: <20030102135350.24315441.gigerstyle@gmx.ch>
	<20030103020358.2c0e6714.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003 02:03:58 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Thu, 2 Jan 2003 13:53:50 +0100 Marc Giger <gigerstyle@gmx.ch> wrote:
> >
> > My "problem" is that my Dual-Box won't power off itself after a shutdown.
> 
> Has it ever?  What kernel version are you trying this on?

With Linux never! With W....... no problem.

2.2.16, 2.2.18, and most of 2.4.

Now I'm running a 2.4.19 with openmosix patches..

> 
> > I tried with 
> > 
> > apm=smp-power-off	//no effect
> > apm=power-off		//this one oopses on boot
> 
> This second should work on any kernel since early 2000.

As I already said, with the second argument it oopses on boot...

> 
> However, there are many SMP machines that cannot be powered off
> using APM.  APM is not defined for SMP machines, and the result
> you got is why APM is not enabled easily on SMP boxes.

yep...I know it...

> 
> > Has someone a hint for me?
> 
> You could try ACPI in (very) recent kernels.

You mean a 2.5.x kernel? Any Kernel with the newest ACPI patches has never powered off any of my machines:-(
Perhaps I don't know something...
I will try it now again...

Thank you

Marc
