Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132839AbRDPCke>; Sun, 15 Apr 2001 22:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132843AbRDPCkY>; Sun, 15 Apr 2001 22:40:24 -0400
Received: from mail.inconnect.com ([209.140.64.7]:16813 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S132839AbRDPCkJ>; Sun, 15 Apr 2001 22:40:09 -0400
Date: Sun, 15 Apr 2001 20:40:08 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
To: David Findlay <david_j_findlay@yahoo.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <01041707532801.00352@workshop>
Message-ID: <Pine.SOL.4.30.0104152031580.28965-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Findlay said once upon a time (Tue, 17 Apr 2001):

> I am using the kernel IP Accounting in Linux to record the amount of data
> transfered via my Linux internet gateway from individual IP addresses. This
> currently requires me to set up an accounting rule for each IP address that I
> want to record accounting info for. If I had 200 machines to individually log
> this would require me to set 200 rules.

In 1999 I setup a Linux kernel 2.2 box to monitor traffic for about 2500
hosts.  I created two rules for each host (to monitor inbound and
outbound).  I had over 5000 total rules on a Pentium II 300 Mhz box.  I
wrote some perl glue so I could accounts on a per customer basis (each
customer had one or more IPs, not necessarily contiguous) and graph the
results in MRTG.

There was ZERO performance problems on the box.  The box is still
runningly happily today.  I don't there is a "problem" to fix.

Dax

