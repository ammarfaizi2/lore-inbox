Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbUK0ESk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUK0ESk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbUK0D7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:39 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261217AbUKZTag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:36 -0500
Date: Thu, 25 Nov 2004 19:22:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 19/51: Remove MTRR sysdev support.
Message-ID: <20041125182250.GI1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101295453.5805.263.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101295453.5805.263.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch removes sysdev support for MTRRs (potential SMP hang and
> shouldn't be done with interrupts done anyway). Instead, we save and
> restore MTRRs when entering and exiting the processor freezers (ie when
> saving the registers & context for each CPU via an SMP call).

This will break acpi s3...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

