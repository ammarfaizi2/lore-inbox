Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUHWSVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUHWSVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUHWSVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:21:09 -0400
Received: from zero.aec.at ([193.170.194.10]:24070 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266333AbUHWSRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:17:42 -0400
To: Roland Dreier <roland@topspin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [broken?] Add MSI support to e1000
References: <2wpoS-1ai-1@gated-at.bofh.it> <2wqXF-2jm-29@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 23 Aug 2004 20:17:32 +0200
In-Reply-To: <2wqXF-2jm-29@gated-at.bofh.it> (Roland Dreier's message of
 "Mon, 23 Aug 2004 19:40:11 +0200")
Message-ID: <m3oel1hg77.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> writes:

>     Tom> I do not see anything wrong with the patch and the kernel MSI
>     Tom> support because it works for a short time. Ganesh may provide
>     Tom> an answer on the MSI support in e1000 hardware.
>
> Based on the e1000 documentation I have, the only thing required for
> the e1000 to use MSI is to set the MSI enable bit in the PCI header.
> Of course there may be some e1000 erratum involving MSI but I have not
> been able to find any indication that this is the case.

There seems to be something wrong with the MSI code in the kernel.
I tried to add MSI support to the s2io driver on x86-64, but it just didn't
work (/proc/interrupts still displayed IO-APIC mode). I haven't 
investigated in detail yet though.

-Andi


