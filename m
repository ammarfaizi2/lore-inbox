Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284621AbRLETrg>; Wed, 5 Dec 2001 14:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284616AbRLETrR>; Wed, 5 Dec 2001 14:47:17 -0500
Received: from [209.249.147.248] ([209.249.147.248]:55057 "EHLO
	proxy1.addr.com") by vger.kernel.org with ESMTP id <S284614AbRLETrE>;
	Wed, 5 Dec 2001 14:47:04 -0500
Date: Wed, 5 Dec 2001 14:43:40 -0500
From: Daniel Gryniewicz <dang@fprintf.net>
To: James Cassidy <jcassidy@nova.qfire.net>
Cc: john@deater.net, cory.bell@usa.net, linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-Id: <20011205144340.4d32ab64.dang@fprintf.net>
In-Reply-To: <20011205134827.A10335@qfire.net>
In-Reply-To: <1007541620.2340.2.camel@localhost.localdomain>
	<Pine.LNX.4.33.0112051127390.27471-100000@pianoman.cluster.toy>
	<20011205115450.6c66664d.dang@fprintf.net>
	<20011205134827.A10335@qfire.net>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, it was.  After I sent that mail, I saw something by Alan saying APIC and
PM don't work together well, so I turned off APIC, and it no longer hangs.  

Daniel

On Wed, 5 Dec 2001 13:48:27 -0500
James Cassidy <jcassidy@nova.qfire.net> wrote:

> 
> 	When ACPI hung on boot did you have APIC/IO-APIC compiled into
> your kernel? I found when I compiled in APIC/IO-APIC on my Compaq presario
> laptop it would hang on bootup also. Appears to get stuck when writing
> out to a IO-Port.
> 
> 						-- James (QFire)
> 
> > I have an N5415, and am using your k7 patch (thanks much!).  I don't use
USB,
> > so I didn't try or comment on your patch.  However, I was never able to
get
> > ACPI to work.  If I compiled it in without APM compiled in, it always hung
on
> > boot.  So, I have only APM, which doesn't even show the battery life
> > correctly.  Whether or not I can suspend, knowing battery life would be an
> > improvement.  Is there something special I have to do to get ACPI to work?

> > (I'm currently using 2.4.13-ac7-preempt-k7, but I've tried 2.4.1[56] also,
as
> > well as many earlier kernels.)
> > 
> > Daniel
> > --- 
> > Recursion n.:
> >         See Recursion.
> >                         -- Random Shack Data Processing Dictionary



--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

