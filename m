Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVBIToJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVBIToJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVBIToJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:44:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13580 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261881AbVBIToG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:44:06 -0500
Date: Wed, 9 Feb 2005 19:44:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Sven Dietrich <sdietrich@mvista.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Preempt Real-time for ARM
Message-ID: <20050209194401.A8810@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Walker <dwalker@mvista.com>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Sven Dietrich <sdietrich@mvista.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
References: <1107628604.5065.54.camel@dhcp153.mvista.com> <1107948492.17747.31.camel@tglx.tec.linutronix.de> <20050209113140.GB13274@elte.hu> <20050209125044.A6312@flint.arm.linux.org.uk> <1107970869.10177.12.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1107970869.10177.12.camel@dhcp153.mvista.com>; from dwalker@mvista.com on Wed, Feb 09, 2005 at 09:41:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 09:41:10AM -0800, Daniel Walker wrote:
> 	All I want to do is integrate the common IRQ threading code. To do that
> I need things , from Russell, like per descriptor locks .. And I need
> things , from Ingo, like pulling out the IRQ threading code..

I've said why per-IRQ locks are incorrect for the non-RT cases on ARM,
but unfortunately just repeating the reasons why it's wrong isn't
getting me anywhere either.  So shrug, all I can to is explain why
it's wrong, and if people choose not to listen there's nothing more
I can do.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
