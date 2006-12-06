Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760354AbWLFJQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760354AbWLFJQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760360AbWLFJQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:16:15 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:60034 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760354AbWLFJQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:16:13 -0500
Date: Wed, 6 Dec 2006 10:14:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
In-Reply-To: <20061206090715.GA30931@elte.hu>
Message-ID: <Pine.LNX.4.61.0612061014090.30117@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz>
 <20061206083730.GB24851@elte.hu> <Pine.LNX.4.64.0612060940130.28502@twin.jikos.cz>
 <20061206085428.GA28160@elte.hu> <Pine.LNX.4.64.0612060957180.28502@twin.jikos.cz>
 <20061206090715.GA30931@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 6 2006 10:07, Ingo Molnar wrote:
>
>i'll probably ack such a patch, it can be useful even when the line 
>number is unique: if someone reports a WARN_ON() from an old kernel i 
>dont have to dig up the exact source but can see it right from the 
>condition what happened. Useful redundancy in bug output can be quite 
>useful at times. Please post it and we'll see whether it's acceptable.
>

Or just make it a compile-time decision, so those who do not want the 5k
overhead do not get it.


	-`J'
-- 
