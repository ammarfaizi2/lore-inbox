Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265615AbUEZN5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUEZN5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUEZN5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:57:16 -0400
Received: from zero.aec.at ([193.170.194.10]:61189 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265615AbUEZN5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:57:12 -0400
To: Ingo Molnar <mingo@elte.hu>
cc: andrea@suse.de, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: 4k stacks in 2.6
References: <1ZQpn-1Rx-1@gated-at.bofh.it> <1ZQz8-1Yh-15@gated-at.bofh.it>
	<1ZRFf-2Vt-3@gated-at.bofh.it> <203Zu-4aT-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 26 May 2004 15:57:05 +0200
In-Reply-To: <203Zu-4aT-15@gated-at.bofh.it> (Ingo Molnar's message of "Wed,
 26 May 2004 12:40:16 +0200")
Message-ID: <m3aczvxpe6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
>
> do you realize that the 4K stacks feature also adds a separate softirq
> and a separate hardirq stack? So the maximum footprint is 4K+4K+4K, with

A nice combination would be 8K process stacks with separate irq stacks on 
i386.

Any chance the CONFIGs for those two could be split? 

-Andi

