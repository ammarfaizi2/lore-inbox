Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRANCeG>; Sat, 13 Jan 2001 21:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRANCdy>; Sat, 13 Jan 2001 21:33:54 -0500
Received: from ausxc10.us.dell.com ([143.166.98.229]:60939 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S129604AbRANCdu>; Sat, 13 Jan 2001 21:33:50 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9BB5@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: stephenc@theiqgroup.com, linux-kernel@vger.kernel.org
Subject: RE: 2.4.0 oops bdflush
Date: Sat, 13 Jan 2001 20:31:11 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Clouse [mailto:stephenc@theiqgroup.com]
> We have a development SMP machine which runs a myriad of 
> server applications for
> our development purposes -- Apache, Oracle, several others.  
> Under 2.4.0 the
> machine locks up, seemingly at random.  Usually it simply 
> stops responding
> without fanfare -- you can, oddly enough, switch consoles 
> with Alt+F?, but
> typing gets no response and all network services have stopped
> responding.

I've seen exactly this same behavior, on an 8-way Xeon (Dell PowerEdge
8450), with 8GB RAM, but never with either 512MB or 1GB, running 20
instances of a copy-and-compare script using /usr/share/doc from Red Hat
Linux 7 as the data source.  I see you're using IDE disks, which makes me
feel better, as I was testing the new megaraid driver.  Magic sysrq works in
my case.  I've never gotten the oops though, I used magic sysrq to print the
IP several times and then tried to look it up.  For me, lockup happens in
the first few minutes of running this test.  I'm happy to try to reproduce
it if anyone has suggestions.

Thanks,
Matt






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
