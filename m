Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSLMJQx>; Fri, 13 Dec 2002 04:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSLMJQx>; Fri, 13 Dec 2002 04:16:53 -0500
Received: from are.twiddle.net ([64.81.246.98]:49281 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261732AbSLMJQx>;
	Fri, 13 Dec 2002 04:16:53 -0500
Date: Fri, 13 Dec 2002 01:24:39 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Matt Reppert <arashi@arashi.yi.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] "extern inline" to "static inline" allows compile
Message-ID: <20021213012439.A7406@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Matt Reppert <arashi@arashi.yi.org>, linux-kernel@vger.kernel.org
References: <20021212170902.34e344b1.arashi@arashi.yi.org> <20021213002028.C2CC72C0AB@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021213002028.C2CC72C0AB@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Dec 13, 2002 at 11:18:57AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 11:18:57AM +1100, Rusty Russell wrote:
> This patch is simple, but not trivial, and since RTH wrote this, I'm
> assuming all those __EXTERN_INLINE's are defined and undefned in
> multiple places for a reason.

Indeed.

> Richard?

Fixed properly by reverting the asm-alpha/pci.h patch
and including asm/io.h in drivers/scsi/sr_ioctl.c.


r~
