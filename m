Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSAZNi5>; Sat, 26 Jan 2002 08:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284890AbSAZNir>; Sat, 26 Jan 2002 08:38:47 -0500
Received: from trantor.cosmic.com ([209.58.189.187]:271 "EHLO cosmic.com")
	by vger.kernel.org with ESMTP id <S284794AbSAZNig>;
	Sat, 26 Jan 2002 08:38:36 -0500
From: mirian@cosmic.com (Mirian Crzig Lennox)
X-Newsgroups: cosmic.linux.kernel
Subject: Re: network hangs, NETDEV WATCHDOG messages, Dual AMD Duron, APIC
Date: Sat, 26 Jan 2002 13:38:37 +0000 (UTC)
Organization: The Cosmic Computing Corporation of Alpha Centauri
Message-ID: <slrna55cat.h4s.mirian@trantor.cosmic.com>
In-Reply-To: <Pine.LNX.4.44.0201240823470.28541-100000@netfinity.realnet.co.sz>
X-Complaints-To: news@trantor.cosmic.com
User-Agent: slrn/0.9.6.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 08:25:05 +0200 (SAST), Zwane Mwaikambo <zwane@linux.realnet.co.sz> wrote:
>Have you tested with another NIC? I've witnessed a problem similar to 
>yours recently (specific machines could login to a Samba server and i 
>could ssh out to/from the server but file copies from Samba failed after 
>copying 20-30 files. Please test with another NIC (another Tulip maybe?) 
>so that we can determine wether its a hardware/kernel issue.

The NIC I was using was a NetGear Lite-On PNIC.  I swapped it out with
another one, and got exactly the same behavior.  Then I swapped in a
3C905B, and the problem disappeared; the network works fine.

Just out of curiosity, I tried another NIC, a Kington KNE100TX.  That
card didn't work at all, in fact, it somehow zapped my CMOS.  I went
back to the 3C905B.

After reading some more reports of problems with AMDs, I should also
mention that I'm using an AGP video card (an Asus GeForce3).  The card
itself isn't giving me trouble, and I've experienced none of the hangs
or Oopses that others have, but APIC issues do seem to manifest in
bizarre ways.

>Also consider that Duron SMP is not a supported configuration, and 
>therefore CPU/PIC based issues like APIC problems aren't going to get you 
>far with some of the kernel hackers.

That's interesting.  Well, in that case, I can report that my Duron SMP
works pretty well.  The only problem I've encountered has been the
network problem with certain cards; everything else works a treat on the
2.4 series kernels.

Thanks for your help and advice,
--Mirian

