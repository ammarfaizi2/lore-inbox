Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbUJaScK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUJaScK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 13:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUJaScK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 13:32:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37808 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261492AbUJaScI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 13:32:08 -0500
Subject: Re: HP C2502 SCSI card (NCR 53C400A based) not working
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41851D24.3040303@rainbow-software.org>
References: <4184D8EB.6000306@rainbow-software.org>
	 <1099236179.16385.16.camel@localhost.localdomain>
	 <41851D24.3040303@rainbow-software.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099243737.16414.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 31 Oct 2004 17:29:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-31 at 17:13, Ondrej Zary wrote:
> I forgot to say that I'm trying this in 2.6.9. I've tried options like this:
> ncr_53c400a=1 ncr_addr=0x350 ncr_irq=255
> also tried ncr_53c400=1 (without the 'a'), various addresses and IRQs.
> It never worked. I always get "scsi0: bus busy, attempting abort", etc.
> and even Oops sometimes.

The driver hasn't been updated fully to 2.6 so thats not suprising (it
ought to be marked && BROKEN I guess)


