Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161356AbWJKTXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161356AbWJKTXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWJKTXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:23:01 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:35227 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161356AbWJKTXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:23:00 -0400
Message-ID: <452D4491.30806@garzik.org>
Date: Wed, 11 Oct 2006 15:22:57 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: eranian@hpl.hp.com, david.mosberger@acm.org, akpm@osdl.org
Subject: Re: [PATCH] Add carta_random32() library routine
References: <200610111900.k9BJ01M4021853@hera.kernel.org>
In-Reply-To: <200610111900.k9BJ01M4021853@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit e0ab2928cc2202f13f0574d4c6f567f166d307eb
> tree 3df0b8e340b1a98cd8a2daa19672ff008e8fb7f9
> parent b611967de4dc5c52049676c4369dcac622a7cdfe
> author Stephane Eranian <eranian@hpl.hp.com> 1160554905 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> 1160590461 -0700
> 
> [PATCH] Add carta_random32() library routine
> 
> This is a follow-up patch based on the review for perfmon2.  This patch
> adds the carta_random32() library routine + carta_random32.h header file.
> 
> This is fast, simple, and efficient pseudo number generator algorithm.  We
> use it in perfmon2 to randomize the sampling periods.  In this context, we
> do not need any fancy randomizer.

hrm, does this really warrant inclusion into every kernel build, on 
every platform?

	Jeff


