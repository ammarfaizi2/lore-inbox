Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUGGJbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUGGJbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 05:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUGGJbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 05:31:19 -0400
Received: from zero.aec.at ([193.170.194.10]:37385 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265002AbUGGJbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 05:31:18 -0400
To: "Harald Dunkel" <harald.dunkel@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: asm-x86_64/bitops.h: problem with long vs int?
References: <2fg8d-36c-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 07 Jul 2004 11:31:14 +0200
In-Reply-To: <2fg8d-36c-5@gated-at.bofh.it> (Harald Dunkel's message of
 "Wed, 07 Jul 2004 10:40:05 +0200")
Message-ID: <m3y8lwcgf1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Harald Dunkel" <harald.dunkel@t-online.de> writes:

> Hi folks,
>
> Maybe its just a cosmetic problem, but the definitions
> for set_bit() and clear_bit() in asm-x86_64/bitops.h
> look a little bit asymmetrical:
>
> static __inline__ void set_bit(long nr, volatile void * addr)
> static __inline__ void clear_bit(int nr, volatile void * addr)
>

It's cosmetic, but I changed set_bit to be int now too. Thanks.

-Andi

