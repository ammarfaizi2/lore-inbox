Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUG1Bej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUG1Bej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUG1Bej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:34:39 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:27867 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266756AbUG1Bei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:34:38 -0400
Date: Tue, 27 Jul 2004 21:38:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
In-Reply-To: <20040727173703.0174a76e.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0407272132400.932@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0407270432470.23989@montezuma.fsmlabs.com>
 <20040727132638.7d26e825.ak@suse.de> <Pine.LNX.4.58.0407271006290.23985@montezuma.fsmlabs.com>
 <20040727173703.0174a76e.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Andi Kleen wrote:

> > the reduced interrupt latency, the code size issue can also be taken care
> > of, but that requires benchmarking as the change is a bit more drastic.
>
> Do you have numbers on that? Frankly if someone is spinning on irq disabled
> locks for a long time they should just fix their code.

It wasn't i who saw the contention but something Keith ran into, the
contention probably wasn't bad enough to require serious locking changes.
