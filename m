Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUAEQH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUAEQH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:07:28 -0500
Received: from ns.suse.de ([195.135.220.2]:6117 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261731AbUAEQH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:07:27 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Mueller <d.mueller@elsoft.ch>, Tom Rini <trini@kernel.crashing.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PPC32: Fix the floppy driver, on CONFIG_NOT_COHERENT_CACHE.
References: <200401032002.i03K25Y9024335@hera.kernel.org>
	<Pine.GSO.4.58.0401051504050.3740@waterleaf.sonytel.be>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm young..  I'm HEALTHY..  I can HIKE THRU CAPT GROGAN'S LUMBAR
 REGIONS!
Date: Mon, 05 Jan 2004 17:07:23 +0100
In-Reply-To: <Pine.GSO.4.58.0401051504050.3740@waterleaf.sonytel.be> (Geert
 Uytterhoeven's message of "Mon, 5 Jan 2004 15:04:47 +0100 (MET)")
Message-ID: <jeisjqnzus.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Fri, 2 Jan 2004, Linux Kernel Mailing List wrote:
>> +#if CONFIG_NOT_COHERENT_CACHE
>    ^^^
> Shouldn't this be #ifdef?

Doesn't matter. Config variables are always either defined to 1 or not
defined at all (which is equivalent to 0 in #if).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
