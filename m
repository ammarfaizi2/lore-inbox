Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310229AbSCLATu>; Mon, 11 Mar 2002 19:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310227AbSCLATk>; Mon, 11 Mar 2002 19:19:40 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:26064 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S310229AbSCLATg>; Mon, 11 Mar 2002 19:19:36 -0500
Date: Mon, 11 Mar 2002 19:22:17 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP & APIC problem.
In-Reply-To: <Pine.LNX.4.10.10203111801290.3488-100000@sorrow.ashke.com>
Message-ID: <Pine.LNX.4.33.0203111920430.1437-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> APIC error on CPU0: 00(08)

discussed in the kernel faq.

> My second question:  Is there any chance of getting this working with
> APIC, if not in 2.4.* maybe in a future release?

given that it's a hardware problem, no.  but it *would* be cool
if the kernel noticed repeated APIC warnings and just turned 
off apic use (as if you had booted with noapic).  I'm guessing
this would be ugly, since APIC setup is probably discarded after boot...

