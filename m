Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVAVWNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVAVWNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 17:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVAVWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 17:13:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:27071 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262758AbVAVWMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 17:12:32 -0500
Date: Sat, 22 Jan 2005 23:15:32 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ian Molton <spyro@f2s.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       "David S. Miller" <davem@davemloft.net>,
       "William L. Irwin" <wli@holomorphy.com>,
       Richard Henderson <rth@twiddle.net>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Paul Mackerras <paulus@au.ibm.com>, Tony Luck <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 00/11] Get rid of verify_area() - convert to access_ok()
 and deprecate.
In-Reply-To: <Pine.LNX.4.61.0501172342240.2730@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0501222312040.2813@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501172342240.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Jesper Juhl wrote:

> 
> Here's a series of patches to convert all (or rather almost all) in-kernel 
> users of verify_area() to access_ok(), and then deprecate verify_area().
> 
[...]

Just a small followup to say that this series of patches still applies to 
2.6.11-rc2 (the first one with a little fuzzyness though). If wanted I can 
re-diff these against 2.6.11-rc2.
If I get no feedback (have had none so far) I'll wait until 2.6.11 is out 
the door, then re-diff and re-submit against that.

-- 
Jesper Juhl

