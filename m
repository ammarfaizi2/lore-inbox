Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbULLG5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbULLG5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 01:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbULLG5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 01:57:33 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:53937 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261756AbULLG5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 01:57:32 -0500
Date: Sun, 12 Dec 2004 07:57:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041212065708.GI16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <Pine.LNX.4.61.0412110749070.5214@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412110749070.5214@montezuma.fsmlabs.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 07:50:31AM -0700, Zwane Mwaikambo wrote:
> Shouldn't that be a bug anyway regardless of dynamic-hz?

Yes of course. And in theory in 2.6 it'll be easier to implement than it
was in 2.4, since it has a chance to be already using USER_HZ at compile
time instead of HZ.
