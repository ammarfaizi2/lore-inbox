Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbULMWyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbULMWyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbULMWyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:54:31 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:42680 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261359AbULMWl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:41:29 -0500
Date: Mon, 13 Dec 2004 23:41:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213224136.GQ16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041213202642.GA11323@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213202642.GA11323@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 09:26:42PM +0100, Olaf Hering wrote:
> Not a comment, more a question:
> 
> Will there be a real benefit by running an old PII 200MMX at 100HZ
> instead of 1000HZ?
> I guess less interrupts should improve the desktop performance a little bit.

On a pii the slowdown is probably more than 1%, the slower the cpu, the
more 100hz is appropriate. This is not going to be very noticeable on a
desktop since a desktop is often idle, but only on servers it should
help (for example kernel compiles will be more than 1% faster).
