Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTFKUCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbTFKUBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:01:46 -0400
Received: from mail.webmaster.com ([216.152.64.131]:65448 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264231AbTFKUBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:01:04 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Artemio" <artemio@artemio.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: SMP question
Date: Wed, 11 Jun 2003 13:14:53 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200306112252.40979.artemio@artemio.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm building a hard real-time Linux (RTLinux) system on a 2x Xeon
> machine. If
> I compile and run a 2.4.18 kernel with SMP support, rtlinux hangs the
> machine. However, with SMP disabled, rtlinux and all it's hard-realtime
> applications runs okay.

> So, I have to deside between these two:

>  - Run rtlinux and hard-realtime applications on a kernel without
> SMP support.
> How much performance will I loose this way? Is SMP *THAT* critical?

	You will lose about half your CPU power.

>  - Run all tasks in a usual way, no hard realtime, but with SMP support.

> What would you suggest?

	If you don't install a kernel with SMP support, you might as well remove
one processor.

> Also, if I turn hyperthreading off, how will it influence the
> system with SMP
> support? Without SMP support?

	In a system with more than one physical CPU, hyperthreading is not that big
of a performance boost.

	DS


