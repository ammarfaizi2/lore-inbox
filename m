Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318346AbSHEJHP>; Mon, 5 Aug 2002 05:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318347AbSHEJHO>; Mon, 5 Aug 2002 05:07:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1247 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318346AbSHEJHO>; Mon, 5 Aug 2002 05:07:14 -0400
Date: Mon, 5 Aug 2002 11:10:46 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "Robert A. Hayden" <rhayden@geek.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 crashdump - P4/3ware/NFS
In-Reply-To: <Pine.LNX.4.33.0207301837440.1473-100000@titan.odeon.net>
Message-ID: <Pine.NEB.4.44.0208051104300.27501-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Robert A. Hayden wrote:

>...
> Several times now the p4 system has either frozen (usually with a
> crashdump), or just mysteriously rebooted while moving large quantities of
> data over the NFS link.
>
> I'm at a loss to explain this unless it starts to point to hardware
> problems (bad CPU? Memory? motherboard?).  I thought for a bit it was due
>...
> I don't have a text log of the dump, but I did take a digital picture of
> it at http://www.roberthayden.com/crashdump.jpg
>
> If anyone has ANY thoughts here, they would be appreciated.  I hate to
> start randomly replacing parts without an idea where to look.

- Does this problem still exist in 2.4.19?
- Are there temperature problems inside your machine?
- Does your power supply give your system enough energy?
- You can test your memory using memtest86 [1].
- Is there anything in the logfiles after the machine "mysteriously
  rebooted"?
- If none of the above helps, could you type the information of the
  screenshot (best the information if it happens using 2.4.19) to a file
  and run it through ksymoops?

> Thanks all.
>
> Robert
>...

cu
Adrian

[1] http://www.memtest86.com/

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


