Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWCTVGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWCTVGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWCTVGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:06:08 -0500
Received: from ns2.suse.de ([195.135.220.15]:63191 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030295AbWCTVGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:06:06 -0500
From: Andreas Schwab <schwab@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jeff Garzik <jeff@garzik.org>,
       joe.korty@ccur.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
	<20060320171905.GA4228@tsunami.ccur.com> <441EFCB0.6020007@garzik.org>
	<Pine.LNX.4.61.0603202022590.3457@yvahk01.tjqt.qr>
	<Pine.LNX.4.64.0603201132070.3622@g5.osdl.org>
X-Yow: I want to kill everyone here with a cute colorful Hydrogen Bomb!!
Date: Mon, 20 Mar 2006 22:05:49 +0100
In-Reply-To: <Pine.LNX.4.64.0603201132070.3622@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 20 Mar 2006 11:33:05 -0800 (PST)")
Message-ID: <je1wwwx1w2.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So the rigt answer is to do both: make sure that people don't use kernel 
> headers, but also try to keep them reasonably clean.

strace is kind of special, since it needs to operate very close to the
kernel (interpreting syscall arguments below all libc wrappers).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
