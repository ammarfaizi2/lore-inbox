Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284560AbRLESs4>; Wed, 5 Dec 2001 13:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284539AbRLESsr>; Wed, 5 Dec 2001 13:48:47 -0500
Received: from net24-164-102-119.neo.rr.com ([24.164.102.119]:20107 "EHLO
	nova.qfire.net") by vger.kernel.org with ESMTP id <S284560AbRLESsi>;
	Wed, 5 Dec 2001 13:48:38 -0500
From: James Cassidy <jcassidy@nova.qfire.net>
Date: Wed, 5 Dec 2001 13:48:27 -0500
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: John Clemens <john@deater.net>, cory.bell@usa.net,
        linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011205134827.A10335@qfire.net>
In-Reply-To: <1007541620.2340.2.camel@localhost.localdomain> <Pine.LNX.4.33.0112051127390.27471-100000@pianoman.cluster.toy> <20011205115450.6c66664d.dang@fprintf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011205115450.6c66664d.dang@fprintf.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	When ACPI hung on boot did you have APIC/IO-APIC compiled into
your kernel? I found when I compiled in APIC/IO-APIC on my Compaq presario
laptop it would hang on bootup also. Appears to get stuck when writing
out to a IO-Port.

						-- James (QFire)

> I have an N5415, and am using your k7 patch (thanks much!).  I don't use USB,
> so I didn't try or comment on your patch.  However, I was never able to get
> ACPI to work.  If I compiled it in without APM compiled in, it always hung on
> boot.  So, I have only APM, which doesn't even show the battery life
> correctly.  Whether or not I can suspend, knowing battery life would be an
> improvement.  Is there something special I have to do to get ACPI to work? 
> (I'm currently using 2.4.13-ac7-preempt-k7, but I've tried 2.4.1[56] also, as
> well as many earlier kernels.)
> 
> Daniel
> --- 
> Recursion n.:
>         See Recursion.
>                         -- Random Shack Data Processing Dictionary
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
