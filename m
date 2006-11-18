Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755818AbWKRBjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818AbWKRBjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 20:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbWKRBjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 20:39:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52629 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755818AbWKRBjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 20:39:22 -0500
Date: Sat, 18 Nov 2006 01:42:28 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
Message-ID: <20061118014228.1d56b592@localhost.localdomain>
In-Reply-To: <20061118000629.GW31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061117142145.GX31879@stusta.de>
	<20061117143236.GA23210@devserv.devel.redhat.com>
	<20061118000629.GW31879@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006 01:06:29 +0100
> Oh, and if anything starts complaining "But this adds some warnings to 
> my kernel build!", he should either first fix the 200 kB (sic) of 
> warnings I'm getting in 2.6.19-rc5-mm2 starting at MODPOST or go to hell.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

The only significant user remaining is the old ISDN code so it doesn't
create too many of them. 

Acked-by: Alan Cox <alan@redhat.com>
