Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268163AbUG2PcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268163AbUG2PcN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbUG2P3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:29:45 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2]:58275 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id S268168AbUG2P23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:28:29 -0400
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mke2fs -j goes nuts on 3Ware 8506-4LP
References: <200407281050.24958.m.watts@eris.qinetiq.com>
	<200407291606.58636.m.watts@eris.qinetiq.com>
	<ufa8yd2vodw.fsf@epithumia.math.uh.edu>
	<200407291620.10226.m.watts@eris.qinetiq.com>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: 29 Jul 2004 10:28:27 -0500
In-Reply-To: <200407291620.10226.m.watts@eris.qinetiq.com>
Message-ID: <ufa4qnqvnms.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MW" == Mark Watts <m.watts@eris.qinetiq.com> writes:

MW> Ok - it seems it doesn't matter what kind of slot its in then -
MW> mine is in a 32bit/33MHz slot.

It's not hard to saturate a bus at that speed, but you don't seem to
be getting to that point.

My experience with 3ware cards is that they will happily saturate any
bus you plug them into as long as the drives are fast enough.  On a
machine with a 3w7506-8 card on each of two buses running software
RAID striping across them, both cards will saturate their respective
buses.  (I have a few machines like this.)  I really doubt that the
cards are the root of the issue here.

 - J<
