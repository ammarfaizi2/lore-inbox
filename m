Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756498AbWKSIAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756498AbWKSIAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 03:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756499AbWKSIAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 03:00:06 -0500
Received: from cantor.suse.de ([195.135.220.2]:19924 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1756498AbWKSIAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 03:00:03 -0500
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Regard MSRs in lapic_suspend()/lapic_resume()
References: <200611180300.18581.fzu@wemgehoertderstaat.de>
From: Andi Kleen <ak@suse.de>
Date: 19 Nov 2006 08:59:51 +0100
In-Reply-To: <200611180300.18581.fzu@wemgehoertderstaat.de>
Message-ID: <p73velbc1e0.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese <fzu@wemgehoertderstaat.de> writes:

> Read/Write APIC_LVTPC and APIC_LVTTHMR only,
> if get_maxlvt() returns certain values.
> This is done like everywhere else in i386/kernel/apic.c,
> so I guess its correct.
> Suspends/Resumes to disk fine and eleminates an smp_error_interrupt()
> here on a K8.

Added thanks.

I also ported it to x86-64

-Andi
