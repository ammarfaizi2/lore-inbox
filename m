Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264279AbUE3Ryp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbUE3Ryp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUE3Ryp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:54:45 -0400
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:62114 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S264279AbUE3Ryn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:54:43 -0400
From: Luis Miguel =?iso-8859-1?q?Garc=EDa_Mancebo?= <ktech@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1 breaks forcedeth
Date: Sun, 30 May 2004 19:54:40 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405301954.40111.ktech@wanadoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lee Howard wrote:
> > I use the forcedeth driver for my nVidia ethernet successfully with 
> > kernel 2.6.6.  I recently tested 2.6.7-rc1, and when using it the 
> > ethernet does not work, and I see this in dmesg:
> > 
> > eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
> > NETDEV WATCHDOG: eth1: transmit timed out
> > NETDEV WATCHDOG: eth1: transmit timed out
> > NETDEV WATCHDOG: eth1: transmit timed out
> > NETDEV WATCHDOG: eth1: transmit timed out
> > NETDEV WATCHDOG: eth1: transmit timed out
> > 
> > I can ping localhost and the device's IP number, but I cannot ping other 
> > systems' IP numbers.
> 
> 
> Well, there are zero changes to the driver itself, so I would guess ACPI 
> perhaps...
> 
> Try booting with 'acpi=off' or 'noapic' or 'pci=noacpi' or similar...
> 
>         Jeff

The same here with nforce2 too. Actually I cannot test that, but I can confirm 
problems with the ethernet driver in -rc1. Perhaps I can test on tuesday if 
-rc2 works or the options you mention above.

Now that you remember me... I remember seeing one message... something about 
problems with IRQ # 9.

Thanks.,
-- 
Luis Miguel García Mancebo
Universidad de Deusto / Deusto University
Spain
