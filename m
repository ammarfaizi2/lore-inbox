Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUEYTNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUEYTNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbUEYTNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:13:11 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14596 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265048AbUEYTNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:13:07 -0400
Subject: Re: System clock running too fast
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200405252049.19704.mbuesch@freenet.de>
References: <200405251939.47165.mbuesch@freenet.de>
	 <1085510708.1689.1.camel@teapot.felipe-alfaro.com>
	 <200405252049.19704.mbuesch@freenet.de>
Content-Type: text/plain
Message-Id: <1085512382.1689.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Tue, 25 May 2004 21:13:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-25 at 20:49, Michael Buesch wrote:
> On Tuesday 25 May 2004 20:45, you wrote:
> > Have you tried enabling CONFIG_HPET_TIMER *or* CONFIG_X86_PM_TIMER to
> > see if it helps? They support high accuracy timers.
> 
> Do they need special hardware support, that may be
> unavailable in such an old machine? You remember it's
> a Pentium 1 Socket 7 With EDO Ram.
> If not, I will try the options on my next planned kernel-update.

Oops... I didn't notice the Pentium I stuff. This discards
CONFIG_HPET_TIMER and will probably leave the CONFIG_X86_PM_TIMER out
as, AFAIK, it depends on ACPI. I don't know if your machine does have a
working ACPI implementation, even more if it will be able to support
CONFIG_X86_PM_TIMER. So, I must confess my total ignorance on such an
old hardware. Anyone?

