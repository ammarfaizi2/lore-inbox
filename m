Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWEPOTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWEPOTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWEPOTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:19:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751111AbWEPOTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:19:02 -0400
Date: Tue, 16 May 2006 07:15:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Stian B. Barmen" <stian@barmen.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide hdma dma_timer_expiry
Message-Id: <20060516071541.1072c360.akpm@osdl.org>
In-Reply-To: <ZULUhx27kBnccYTjr8c00000042@zulu.barmen.nu>
References: <ZULUhx27kBnccYTjr8c00000042@zulu.barmen.nu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stian B. Barmen" <stian@barmen.nu> wrote:
>
> 1.] One line summary of the problem:
> 
>  Kernel Panic every 24-48 hours after upgrade from 2.6.15.4 -> 2.6.16.15
> 
>  [2.] Full description of the problem/report:
> 
>  After the upgrade the screen freezes, usually in the night with a kernel 
>  panic,
>  but when I get there the screen is black so I never get to see the panic 
>  itself. Anyways I
>  looked in the syslog and the last entry was:
> 
>  May 16 04:22:39 [kernel] [234964.520730] hdi: dma_timer_expiry: dma status == 
>  0x61
> 
>  When I downgrade to 2.6.16.4 the problems goes away. Have tried to read the 
>  changelogs but
>  I am stumped as to what the problem is.
> 
>  Hardware IDE wise is alot of disks, 9 IDE disks on 3 controllers, and the hdi 
>  disk is on a Primise Tech 20269 controller. Smartctl does not report any 
>  problems.
> 
>  [3.] Keywords (i.e., modules, networking, kernel):
> 
>  Kernel panic, dma_timer_expiry ide

Can I confirm that 2.6.16.15 is bad and 2.6.16.4 is OK?  Or did you mean
2.6.15.4 there?
