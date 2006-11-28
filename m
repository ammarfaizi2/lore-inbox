Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935566AbWK1Ezv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935566AbWK1Ezv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 23:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935563AbWK1Ezu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 23:55:50 -0500
Received: from amanpulo.hosting.qsr.com.ph ([64.34.170.22]:21908 "EHLO
	amanpulo.hosting.qsr.com.ph") by vger.kernel.org with ESMTP
	id S935566AbWK1Ezt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 23:55:49 -0500
Date: Tue, 28 Nov 2006 12:55:36 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18.3 Lockup on Athlon MP
Message-ID: <20061128045536.GD3092@free.net.ph>
Mail-Followup-To: Federico Sevilla III <jijo@free.net.ph>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061128031701.GC3092@free.net.ph>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128031701.GC3092@free.net.ph>
X-Personal-URL: http://jijo.free.net.ph
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 11:17:01AM +0800, Federico Sevilla III wrote:
> I am experiencing hard lock ups on a dual Athlon MP 2600+ with Linux
> kernel 2.6.18.3. This can be reproduced within two minutes by running
> burnK7 from cpuburn. I am sure it's not just a hardware issue, though,
> since running a 2.6.14 kernel using ServerBeach's "RapidRescue"
> environment allows me to run burnK7 for extended periods without
> locking up the machine.

I found the thread "2.6.18 Nasty Lockup" and tried the suggestion to
boot with clocksource=acpi_pm. The two burnK7 processes have been
running (stressing both CPUs) for 90 minutes now and the system
continues to be responsive.

 --> Jijo

-- 
Federico Sevilla III
F S 3 Consulting Inc.
http://www.fs3.ph
