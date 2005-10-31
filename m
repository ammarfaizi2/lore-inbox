Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVJaUUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVJaUUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVJaUUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:20:42 -0500
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:57814 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S964821AbVJaUUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:20:41 -0500
Date: Mon, 31 Oct 2005 12:26:29 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>, vgoyal@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
In-Reply-To: <m1k6fta91r.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0510311224060.1526@montezuma.fsmlabs.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04DFF@USRV-EXCH4.na.uis.unisys.com>
 <Pine.LNX.4.61.0510310916040.1526@montezuma.fsmlabs.com>
 <m1k6fta91r.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Eric W. Biederman wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:
> 
> >
> > Regarding IOAPIC setup I agree, Eric's patch is causing a few problems;
> >
> > Total of 2 processors activated (14407.06 BogoMIPS).
> > checking TSC synchronization across 2 CPUs: passed.
> > softlockup thread 0 started up.
> > APIC error on CPU1: 00(40) <====
> > Brought up 2 CPUs
> 
> Cool! Bug reports!
> 
> Zwane can I get a little more detail or is this just a warning?
> I don't have enough information to understand what is happening
> on your machine.

I just isolated which patch it was last night so i'm still not sure which 
part of it causes problems. The patch in question is;

i386-nmi_watchdog-merge-check_nmi_watchdog-fixes-from-x86_64.patch

This happens on both a dual P2-400 and a 3.6GHz P4 with HT enabled. What 
kind of information were you after?
