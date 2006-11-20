Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934093AbWKTME0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934093AbWKTME0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 07:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934096AbWKTME0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 07:04:26 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32228 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S934093AbWKTMEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 07:04:25 -0500
Date: Mon, 20 Nov 2006 12:10:15 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Stefan Roese <ml@stefan-roese.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx
 systems
Message-ID: <20061120121015.2fb667d0@localhost.localdomain>
In-Reply-To: <200611201255.37754.ml@stefan-roese.de>
References: <200611201200.36780.ml@stefan-roese.de>
	<20061120114248.60bb0869@localhost.localdomain>
	<200611201255.37754.ml@stefan-roese.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 12:54:32 +0100 (MET)
Stefan Roese <ml@stefan-roese.de> wrote:
> Let's see, if I got this right. You mean that on such a platform, where 0 is a 
> valid physical IRQ, we should assign another value as virtual IRQ number (not 
> 0 and not -1 of course). And then the platform "pic" implementation should 
> take care of the remapping of these virtual IRQ numbers to the physical 
> numbers.
> 
> Correct?

Absolutely correct in all the detail.
