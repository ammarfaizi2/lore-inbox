Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTE3R4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTE3R4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:56:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21003 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263858AbTE3R4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:56:18 -0400
Date: Fri, 30 May 2003 19:09:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it possible?)
Message-ID: <20030530190929.E9419@flint.arm.linux.org.uk>
Mail-Followup-To: Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>
References: <20030530103254.B1669@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530103254.B1669@mvista.com>; from jsun@mvista.com on Fri, May 30, 2003 at 10:32:54AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 10:32:54AM -0700, Jun Sun wrote:
> So my question is: how other CPU arches with the same problem
> implement flush_dcache_page()?  Flushing the whole cache? Or
> have a broken implementation and pretend it is OK?  :)

See __flush_dcache_page() in arch/arm/mm/fault-armv.c in 2.5.70.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

