Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270311AbRHSJq7>; Sun, 19 Aug 2001 05:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270314AbRHSJqt>; Sun, 19 Aug 2001 05:46:49 -0400
Received: from [209.202.108.240] ([209.202.108.240]:16904 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S270311AbRHSJqg>; Sun, 19 Aug 2001 05:46:36 -0400
Date: Sun, 19 Aug 2001 05:46:32 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>, <gars@lanm-pc.com>
Subject: Re: Swap size for a machine with 2GB of memory
In-Reply-To: <20010819024233.A26916@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0108190526090.4118-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Eric S. Raymond wrote:

> The Red Hat installation manual claims that the size of the swap partition
> should be twice the size of physical memory, but no more than 128MB.
>
> The screaming hotrod machine Gary Sandine and I built around the Tyan S2464
> has 2GB of physical memory.  Should I believe the above formula?  If not,
> is there a more correct one for calculating needed swap on machines with
> very large memory?
>
> (No further hangs, BTW.)

I'm not an authority on swap under Linux, but I can tell you about my personal
experiences, and I hope it helps you.

In reality, machines with as little as 192 MB of RAM don't necessarily need
swap space. Of course, it depends on what you're doing with it. A machine like
that would be used solely as a high-powered office machine or a low-grade
workstation.

At the other extreme, I've heard of machines that are running heavy scientific
applications. They have 4 GB of RAM and run with 10+ GB of swap.

A machine with 2 GB of RAM can easily live with no swap, unless you want to
run web, proxy, or database servers in very large configurations, or if you
compile software several times the size of XFree86 with any regularity. By
"very large configurations" I mean something you would have to deliberately
set, probably requiring a change to defined constants in the software.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


