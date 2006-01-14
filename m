Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWANQmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWANQmX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWANQmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:42:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22545 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751111AbWANQmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:42:23 -0500
Date: Sat, 14 Jan 2006 16:42:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.15-mm4] sem2mutex: serial ->port_write_mutex
Message-ID: <20060114164216.GA24816@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20060114163206.GA6131@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114163206.GA6131@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 05:32:06PM +0100, Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> semaphore to mutex conversion.
> 
> the conversion was generated via scripts, and the result was validated
> automatically via a script as well.

I know nothing about these drivers, sorry.

Andrew - would you mind taking this patch instead?

Although folk may think I'm the "everything serial" maintainer, I'm
actually only looking after a very small number of serial drivers.
Hence why my sig says "Serial core" not "Serial".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
