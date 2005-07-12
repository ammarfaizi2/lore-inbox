Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVGLSY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVGLSY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVGLSXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:23:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261934AbVGLSUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:20:24 -0400
Date: Tue, 12 Jul 2005 11:20:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Tomasz Lemiech <szpajder@staszic.waw.pl>
Cc: torvalds@osdl.org, chrisw@osdl.org, len.brown@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.2 acpi_register_gsi() patch causes problems on Asus A7V333 motherboard
Message-ID: <20050712182007.GX19052@shell0.pdx.osdl.net>
References: <Pine.LNX.4.63.0507121940170.11987@boss.staszic.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0507121940170.11987@boss.staszic.waw.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomasz Lemiech (szpajder@staszic.waw.pl) wrote:
> Today I tried 2.6.12.2 on an Asus A7V333 (socket A) with AMD Duron 1300 
> MHz CPU and noticed, that the system clock was running about 60 times 
> faster than real time and the keyboard was unresponsive. However, I was 
> able to log in remotely and collect some standard debugging info (dmesg, 
> lspci, interrupts, config), which is available at 
> http://szpajder.w.staszic.waw.pl/a7v333/ . Summary of my quick research 
> follows:
> 
> - 2.6.12.1 works without problems
> 
> - 2.6.12.2 with acpi=off works without problems
> 
> - 2.6.12.2 with acpi_register_gsi() one-line fix works without problems

One line fix means the 's/>= 0/> 0/' ?  If so, that's currently queued to
the -stable tree and should be present in the forthcoming .3.  If not,
could you please clarify what the one line fix is?

thanks,
-chris
