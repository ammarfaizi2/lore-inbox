Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310603AbSCPUgb>; Sat, 16 Mar 2002 15:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310602AbSCPUgV>; Sat, 16 Mar 2002 15:36:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26634 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310598AbSCPUgF>; Sat, 16 Mar 2002 15:36:05 -0500
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
To: gordonl@world.std.com (Gordon J Lee)
Date: Sat, 16 Mar 2002 20:51:20 +0000 (GMT)
Cc: greg@kroah.com (Greg KH), linux-kernel@vger.kernel.org
In-Reply-To: <3C938693.6D29979C@world.std.com> from "Gordon J Lee" at Mar 16, 2002 12:53:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mL96-000780-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >From your earlier post, I presume that the bug here was simply a presentation
> layer bug in /proc/cpuinfo, and that kernel versions previous to 2.4.19-pre3-ac1
> can actually use all of the logical processors.  Is this correct ?

Not exactly no.

> If so, at which 2.4.x kernel did support for hyperthreading show up?

2.4.19pre, and you want -ac patches for autodetect right now - that should
all be in the main tree for 2.4.19 proper

