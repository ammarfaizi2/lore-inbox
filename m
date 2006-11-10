Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946246AbWKJKMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946246AbWKJKMl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946254AbWKJKMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:12:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27307 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946246AbWKJKMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:12:40 -0500
Subject: Re: [patch 10/19] PM_timer: allow early access and move externs to
	a header file
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061109233035.226521000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233035.226521000@cruncher.tec.linutronix.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 11:12:37 +0100
Message-Id: <1163153557.3138.649.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 23:38 +0000, Thomas Gleixner wrote:
> +/* Overrun value */
> +#define ACPI_PM_OVRRUN	1<<24

technically the PM timer can be either 24 or 32 bits and you can find
out at runtime; 24 is safe value though...


Acked-by: Arjan van de Ven <arjan@linux.intel.com>
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

