Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVFRIQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVFRIQE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 04:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVFRIQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 04:16:02 -0400
Received: from [85.8.12.41] ([85.8.12.41]:51638 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261414AbVFRIPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 04:15:49 -0400
Message-ID: <42B3D830.9060100@drzeus.cx>
Date: Sat, 18 Jun 2005 10:15:44 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ISA DMA controller hangs
References: <42987450.9000601@drzeus.cx> <1117288285.2685.10.camel@localhost.localdomain> <42A2B610.1020408@drzeus.cx> <42A3061C.7010604@drzeus.cx> <42B1A08B.8080601@drzeus.cx> <20050616170622.A1712@flint.arm.linux.org.uk>
In-Reply-To: <20050616170622.A1712@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>
>Shouldn't there be a system device for the DMA controller?  I think
>that should have appropriate hooks into the power management system
>to do the necessary magic to restore whatever's needed - just like
>we do for the PIC.
>
>  
>

I'll have a look at how the PIC is handled then. Any corner cases I
should be aware of?

Rgds
Pierre

