Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVJaRbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVJaRbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVJaRbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:31:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7118 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964795AbVJaRbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:31:34 -0500
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>, vgoyal@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04DFF@USRV-EXCH4.na.uis.unisys.com>
	<Pine.LNX.4.61.0510310916040.1526@montezuma.fsmlabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 31 Oct 2005 10:30:24 -0700
In-Reply-To: <Pine.LNX.4.61.0510310916040.1526@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Mon, 31 Oct 2005 09:18:17 -0800 (PST)")
Message-ID: <m1k6fta91r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:

>
> Regarding IOAPIC setup I agree, Eric's patch is causing a few problems;
>
> Total of 2 processors activated (14407.06 BogoMIPS).
> checking TSC synchronization across 2 CPUs: passed.
> softlockup thread 0 started up.
> APIC error on CPU1: 00(40) <====
> Brought up 2 CPUs

Cool! Bug reports!

Zwane can I get a little more detail or is this just a warning?
I don't have enough information to understand what is happening
on your machine.

Eric

