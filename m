Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130810AbQKBN5w>; Thu, 2 Nov 2000 08:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131014AbQKBN5c>; Thu, 2 Nov 2000 08:57:32 -0500
Received: from kanga.kvack.org ([216.129.200.3]:36623 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S130810AbQKBN5W>;
	Thu, 2 Nov 2000 08:57:22 -0500
Date: Thu, 2 Nov 2000 08:56:06 -0500 (EST)
From: <kernel@kvack.org>
To: "Dr. David Gilbert" <dg@px.uk.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.4.21.0011021339170.24579-100000@springhead.px.uk.com>
Message-ID: <Pine.LNX.3.96.1001102085215.13796A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Dr. David Gilbert wrote:

> I've included /proc/pci, /proc/interrupt /proc/cpuinfo and the kernel
> config (2.4.0-test10).

> CONFIG_MTRR=y

I bet it's the mtrr bugs.  Take a look in /proc/mtrr.  Someone suggested
that if you disable the cachable settings in the BIOS for the BIOS/VGA/ROM
regions, the bug can be avoided.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
