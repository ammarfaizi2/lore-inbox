Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbULMBuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbULMBuz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 20:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbULMBuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 20:50:55 -0500
Received: from fsmlabs.com ([168.103.115.128]:52648 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262191AbULMBuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 20:50:50 -0500
Date: Sun, 12 Dec 2004 18:50:30 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
cc: Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
In-Reply-To: <20041213002751.GP16322@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
 <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org>
 <20041213002751.GP16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Andrea Arcangeli wrote:

> Sure, desktop doesn't need this, the reason somebody is asking for it,
> is that the desktop stuff hurted some other non-desktop usages. Infact
> my 2.4 tree was setting by default HZ=1000 if 'desktop' paramter was
> passed to the kernel (so that I could lower the timeslice accordingly
> too, without losing the effect of the nicelevels between nice 0 and
> +19).
> 
> The other new case where I'm asked for this feature is again not the
> desktop but the high end laptop with cpu throttling down to 80mhz, and
> what Pavel mentioned about the lower consumption. Perhaps we could do
> variable HZ there, though I doubt it has a pit that can be reprogrammed
> with sane performance.

Well most x86(64) these days have local APICs and that provides a 
relatively inexpensive one shot timer mode.

