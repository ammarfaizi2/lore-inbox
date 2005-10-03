Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVJCKHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVJCKHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 06:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVJCKHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 06:07:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6668 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750817AbVJCKHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 06:07:40 -0400
Date: Mon, 3 Oct 2005 11:07:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: vikas gupta <vikas_gupta51013@yahoo.co.in>, bcrl@kvack.org,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-xx-all.diff is not working for 2.6.13 arm kernel
Message-ID: <20051003100731.GB16717@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	vikas gupta <vikas_gupta51013@yahoo.co.in>, bcrl@kvack.org,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org
References: <20051003092208.96452.qmail@web8401.mail.in.yahoo.com> <200510031227.34961.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510031227.34961.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 12:27:34PM +0300, Denis Vlasenko wrote:
> On Monday 03 October 2005 12:22, vikas gupta wrote:
> > hi ben ,
> > 
> > I tried to apply 2.6.13-rc6-B0/B1-all.diff to
> > linux-2.6.13 kernel with arm support patches . It's
> > getting applied cleanly...
> > but while building the kernel i am getting some build
> > errors ... 
> > i traced the problem and get that this error are
> > coming because of some machine specific files.
> > 1)arch/i386/kernel/semaphore.c
> > 2)include/asm-i386/seamphore.h
> > 
> > So can you please tell me that whather any patch is
> > available, in order to support these implementation on
> > arm platform.
> 
> How nice that you did not show the actual error message
> and did not show your .config

That's usual in the embedded world - it's a way that embedded folk seem
to write their bug reports to provoke a "response"  (the content of the
response doesn't seem to matter, just as long as there is one.)

However, one also has to wonder - "2.6.13 kernel with arm support patches"
"arch/i386/kernel/semaphore.c".  Why have "arm" patches been applied (and
what were they) and why i386 is being built.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
