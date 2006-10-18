Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161255AbWJRSGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbWJRSGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161256AbWJRSGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:06:52 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:11470 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1161255AbWJRSGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:06:51 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: Still broken sata (VIA) on Asus A8V (kernel 2.6.14+) with
	irqbalance
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Dyson <Linux@Adelphia.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4536606F.80606@Adelphia.net>
References: <4534F41A.1030504@Adelphia.net>
	 <200610181526.05336.sergio@sergiomb.no-ip.org>
	 <4536606F.80606@Adelphia.net>
Content-Type: text/plain; charset=utf-8
Date: Wed, 18 Oct 2006 19:05:51 +0100
Message-Id: <1161194751.21484.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 13:12 -0400, Dyson wrote:
> I edited the original 2.6.16 quirks.c to not fixup the IDE bus and
> still
> fixup the USB IRQs. 

Please, send /proc/interrupts to see what interrupt is USB ? 
if USB interrupt it lower than 15 should try latest patch.  

I think this always the same problem.
if we don't do the IRQ routing well, the drivers team will workaround,
when we put IRQ routing well, the workaround will blow it.

thanks,
--
Sérgio M. B. 

