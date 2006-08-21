Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWHUNoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWHUNoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWHUNoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:44:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030450AbWHUNoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:44:23 -0400
Date: Mon, 21 Aug 2006 06:44:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
Message-Id: <20060821064411.20e61aa0.akpm@osdl.org>
In-Reply-To: <44E97AF9.2040009@gmail.com>
References: <20060819220008.843d2f64.akpm@osdl.org>
	<44E97AF9.2040009@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 11:20:57 +0200
Maciej Rutecki <maciej.rutecki@gmail.com> wrote:

> Andrew Morton napisał(a):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm2/
> > 
> > 
> 
> I have this entry in dmesg:
> 
> [   23.701949] ACPI Error (utglobal-0125): Unknown exception code:
> 0xFFFFFFEA [20060707]
> [   23.702181] ACPI Error (utglobal-0125): Unknown exception code:
> 0xFFFFFFEA [20060707]
> [   23.705646]   got res [dd000000:dd00ffff] bus [dd000000:dd00ffff]
> flags 7202 for BAR 6 of 0000:01:00.0
> 
> When I try:
> 
> cat standby > /sys/power/state
> 
> graphics card doesn't go to standby, I had this text on console:
> 
> [  280.908000] Stopping tasks: =========================|
> [  280.920000] Suspending console(s)
> 

Can you try reverting git-acpi.patch please?
