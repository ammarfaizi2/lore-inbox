Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbUL1Cz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUL1Cz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUL1Cz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:55:56 -0500
Received: from mail.renesas.com ([202.234.163.13]:40958 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262027AbUL1Czl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:55:41 -0500
Date: Tue, 28 Dec 2004 11:55:16 +0900 (JST)
Message-Id: <20041228.115516.783400549.takata.hirokazu@renesas.com>
To: oleg@tv-sign.ru
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       James.Bottomley@HansenPartnership.com, paulus@samba.org,
       wli@holomorphy.com, davem@davemloft.net, lethal@linux-sh.org,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, takata@linux-m32r.org,
       ak@suse.de, rth@twiddle.net, matthew@wil.cx
Subject: Re: [PATCH] fix conflicting cpu_idle() declarations
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <41D033FE.7AD17627@tv-sign.ru>
References: <41D033FE.7AD17627@tv-sign.ru>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

From: Oleg Nesterov <oleg@tv-sign.ru>
Date: Mon, 27 Dec 2004 19:51:07 +0300
> Hello.
> 
> I am sorry, i misspelled your email in cc list.
> 
> Could you please check arch/m32r/ part?               
> 
> Oleg.

I think it is OK for m32r.

BTW, you moved the definition of cpu_idle() to smp.h.
It may not be included from arch/*/process.c in some archs.
Is it OK?

Thank you.

-- Takata
