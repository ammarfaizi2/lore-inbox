Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbTH2P7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTH2P7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:59:33 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:33798 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261307AbTH2P7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:59:32 -0400
Subject: Re: 2.6.0-test4-mm3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <3F4F747E.7020601@wmich.edu>
References: <20030828235649.61074690.akpm@osdl.org>
	 <3F4F747E.7020601@wmich.edu>
Content-Type: text/plain
Message-Id: <1062172768.671.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 29 Aug 2003 17:59:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 17:42, Ed Sweetman wrote:
> 
> It seems that since test3-mm2 ...possibly mm3, my kernels just hang 
> after loading the input driver for the pc speaker.  Now directly after 
> this on test3-mm1 serio loads.
>   serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1

Please, take a look at
http://bugzilla.kernel.org/show_bug.cgi?id=1123

It's a problem with ACPI interrupt routing, it seems.

