Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUDVTwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUDVTwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUDVTwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:52:15 -0400
Received: from zero.aec.at ([193.170.194.10]:524 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264655AbUDVTwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:52:05 -0400
To: "David S. Miller" <davem@redhat.com>
cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: Large inlines in include/linux/skbuff.h
References: <1NAJr-61F-3@gated-at.bofh.it> <1NRqX-2GI-15@gated-at.bofh.it>
	<1NRqX-2GI-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 22 Apr 2004 21:51:53 +0200
In-Reply-To: <1NRqX-2GI-13@gated-at.bofh.it> (David S. Miller's message of
 "Thu, 22 Apr 2004 20:50:11 +0200")
Message-ID: <m34qrb3i5i.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
>
> He's asking you to test and quantify the performance changes that
> occur as a result of this patch, not to figure it out via calculations
> in your head :-)

I bet it will be completely unnoticeable in macrobenchmarks.

The only way to measure a difference would be likely to use 
some unrealistic microbenchmark (program that calls this in a tight loop)

-Andi

