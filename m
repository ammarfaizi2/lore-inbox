Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUCGH1j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 02:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUCGH1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 02:27:39 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57541 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261774AbUCGH1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 02:27:38 -0500
Date: Sun, 7 Mar 2004 02:27:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Michael Frank <mhf@linuxmail.org>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 AGP interrupt not shown in /proc/interrupts? 
In-Reply-To: <opr4g458l34evsfm@smtp.pacific.net.th>
Message-ID: <Pine.LNX.4.58.0403070225100.29087@montezuma.fsmlabs.com>
References: <opr4g458l34evsfm@smtp.pacific.net.th>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2004, Michael Frank wrote:

> P4, running 2.6.3 with APM using sis-agp.
>
> IRQ10 is used by AGP, why is it not listed in /proc/interrupts?

Because there is no driver handling that device which requires an
interrupt handler. Some DRI drivers are interrupt driven, in which case
you would see the device listed in /proc/interrupts.

