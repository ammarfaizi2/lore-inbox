Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270947AbRIFOfW>; Thu, 6 Sep 2001 10:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270992AbRIFOfM>; Thu, 6 Sep 2001 10:35:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16143 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270947AbRIFOfA>; Thu, 6 Sep 2001 10:35:00 -0400
Subject: Re: page_launder() on 2.4.9/10 issue
To: znmeb@aracnet.com (M. Edward Borasky)
Date: Thu, 6 Sep 2001 15:39:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBOEMFDKAA.znmeb@aracnet.com> from "M. Edward Borasky" at Sep 06, 2001 06:54:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f0JJ-0008E4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> forgive me if I'm asking a silly question or making a silly comment. It
> seems to me, from what I've seen of this discussion so far, that the only
> way one "tunes" Linux kernels at the moment is by changing code and
> rebuilding the kernel. That is, there are few "tunables" that one can set,
> based on one's circumstances, to optimize kernel performance for a specific
> application or environment.

There are a lot of tunables in /proc/sys. An excellent tool for playing with
them is "powertweak". 

> No one "memory management scheme", for example, can be all things to all
> tasks, and it seems to me that giving users tools to measure and control the
> behavior of memory management, *preferably without having to recompile and
> reboot*, should be a major priority if Linux is to succeed in a wide variety
> of applications.

The VM is tunable in the -ac tree. I still believe the VM can and should be
self tuning but we are not there yet.

> OK, I'll get off my soapbox now, and ask a related question. Is there a
> mathematical model of the Linux kernel somewhere that I could get my hands
> on?

Not that I am aware of. 

Alan
