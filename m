Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUAYBni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUAYBni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:43:38 -0500
Received: from [130.57.169.10] ([130.57.169.10]:57730 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S263523AbUAYBng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:43:36 -0500
Subject: Re: 2.6.1 dual xeon
From: Robert Love <rml@ximian.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040124203646.A8709@animx.eu.org>
References: <20040124203646.A8709@animx.eu.org>
Content-Type: text/plain
Message-Id: <1074995006.5246.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.2 (1.5.2-2) 
Date: Sat, 24 Jan 2004 20:43:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-24 at 20:36 -0500, Wakko Warner wrote:

> I recently aquired a dual xeon system.  HT is enabled which shows up as 4
> cpus.  I noticed that all interrupts are on CPU0.  Can anyone tell me why
> this is?

The APIC needs to be programmed to deliver interrupts to certain
processors.

In 2.6, this is done in user-space via a program called irqbalance:

	http://people.redhat.com/arjanv/irqbalance/

If you run Red Hat, it is in the "kernel-utils" package.

	Robert Love


