Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284527AbRLERmb>; Wed, 5 Dec 2001 12:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284531AbRLERmW>; Wed, 5 Dec 2001 12:42:22 -0500
Received: from [209.249.147.248] ([209.249.147.248]:38149 "EHLO
	proxy1.addr.com") by vger.kernel.org with ESMTP id <S284527AbRLERmH>;
	Wed, 5 Dec 2001 12:42:07 -0500
Date: Wed, 5 Dec 2001 11:54:50 -0500
From: Daniel Gryniewicz <dang@fprintf.net>
To: John Clemens <john@deater.net>
Cc: cory.bell@usa.net, linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-Id: <20011205115450.6c66664d.dang@fprintf.net>
In-Reply-To: <Pine.LNX.4.33.0112051127390.27471-100000@pianoman.cluster.toy>
In-Reply-To: <1007541620.2340.2.camel@localhost.localdomain>
	<Pine.LNX.4.33.0112051127390.27471-100000@pianoman.cluster.toy>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001 11:41:44 -0500 (EST)
John Clemens <john@deater.net> wrote:

<snip>

> > ACPI seems to work on my laptop (detects ACPI resources, thermal
> > zone, etc), but if I "cat /proc/acpi/events" and press the suspend or
> > power buttons, I don't get anything. On my old NEC Versa LX, I'd get a
> > few junk chars for each press (been a while since I tried it, though). I
> > don't see any interrupts on IRQ 9, either.
> 
> I'm not 100% sure how ACPI works, period. I've got it up and running, but
> about the only thing it does seem to report correctly is battery life
> (and, I assume, it uses ACPI idle..)..  everything else appears to be just
> window dressing for now.. not sure if that's a limitation of hardware or
> the linux ACPI implementation.

I have an N5415, and am using your k7 patch (thanks much!).  I don't use USB,
so I didn't try or comment on your patch.  However, I was never able to get
ACPI to work.  If I compiled it in without APM compiled in, it always hung on
boot.  So, I have only APM, which doesn't even show the battery life
correctly.  Whether or not I can suspend, knowing battery life would be an
improvement.  Is there something special I have to do to get ACPI to work? 
(I'm currently using 2.4.13-ac7-preempt-k7, but I've tried 2.4.1[56] also, as
well as many earlier kernels.)

Daniel
--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

