Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbTJ0VGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTJ0VGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:06:10 -0500
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:18048
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263588AbTJ0VGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:06:09 -0500
Date: Mon, 27 Oct 2003 16:05:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86
 Architecture
In-Reply-To: <m3k76qsf8i.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.53.0310271603580.21953@montezuma.fsmlabs.com>
References: <JB3R.23s.23@gated-at.bofh.it> <JWKQ.7nS.15@gated-at.bofh.it>
 <LhtX.bs.15@gated-at.bofh.it> <LhtX.bs.13@gated-at.bofh.it>
 <m3k76qsf8i.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Andi Kleen wrote:

> The wmb() change is not needed, unless you have an oostore CPU
> (x86 has ordered writes by default). It probably does not hurt
> neither though (I do it the same way on x86-64), but also doesn't 
> change anything.

The original intent was to fix an SMP P5 system, it oopses otherwise under 
load.
