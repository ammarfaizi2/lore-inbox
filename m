Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131715AbRBQOcH>; Sat, 17 Feb 2001 09:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131739AbRBQOb5>; Sat, 17 Feb 2001 09:31:57 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:56282 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131715AbRBQObu>; Sat, 17 Feb 2001 09:31:50 -0500
Message-ID: <3A8E8C8F.A2A9E69E@uow.edu.au>
Date: Sun, 18 Feb 2001 01:37:03 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Widmann <thomas.widmann@icn.siemens.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP: bind process to cpu
In-Reply-To: <BGEDIODHBENLENEMBEPAEEDFCAAA.thomas.widmann@icn.siemens.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Widmann wrote:
> 
> Hi,
> 
> I run an 3*XEON 550MHz Primergy with 2GB of RAM.
> On this machine, i have compiled kernel 2.4.0SMP.
> 
> Is it possible to bind a process to a specific
> cpu on this SMP machine (process affinity) ?
> 
> I there something like pset ?

A patch which creates /proc/<pid>/cpus_allowed is at

	http://www.uow.edu.au/~andrewm/linux/#cpus_allowed

You just write a bitmask into it.
