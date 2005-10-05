Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbVJEUcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbVJEUcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbVJEUcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:32:36 -0400
Received: from fsmlabs.com ([168.103.115.128]:62659 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030378AbVJEUcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:32:36 -0400
Date: Wed, 5 Oct 2005 13:38:50 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Clemens Koller <clemens.koller@anagramm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
In-Reply-To: <43424AD8.2020508@anagramm.de>
Message-ID: <Pine.LNX.4.61.0510051337010.1684@montezuma.fsmlabs.com>
References: <433A747E.3070705@anagramm.de> <Pine.LNX.4.61.0509280812250.1684@montezuma.fsmlabs.com>
 <433BDC11.7070407@anagramm.de> <Pine.LNX.4.61.0509291243440.1684@montezuma.fsmlabs.com>
 <43424AD8.2020508@anagramm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, Clemens Koller wrote:

> All that is on a Tyan Tomcat IIID (S1563D) machine, w/ the latest BIOS (4.02)
> APM and ACPI are currently disabled...
> 
> Unfortunately, I have had a severe two-at-a-time hard-disk crash on another
> machine, which kept me quite busy the last days. :-(
> Hopefully, by the end of this week, I will be able to debug into that more...
> Can you give me a pointer to some code, where the kernel actually splits
> up in between rebooting and halting the system?

Hello Clemens,
	You can start by having a look at sys_reboot in kernel/sys.c

Cheers,
	Zwane

