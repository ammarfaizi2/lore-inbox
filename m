Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTKWPHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 10:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTKWPHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 10:07:47 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:7370 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id S262106AbTKWPHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 10:07:45 -0500
Date: Sun, 23 Nov 2003 16:06:52 +0100
From: Eduard Bloch <edi@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: not fixed in 2.4.23-rc3 (was: Re: 2.4.22 SMP kernel build for hyper threading P4)
Message-ID: <20031123150652.GA4552@zombie.inka.de>
References: <20031115153950.41EB38407D1@gateway.mailvault.com> <20031115164015.GA24824@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031115164015.GA24824@zombie.inka.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Eduard Bloch [Sat, Nov 15 2003, 05:40:15PM]:

> > I've even build a 2.4.22 kernel with the config-2.4.20-20.9smp
> > configuration that came with RH9.
> 
> I see a very similar behaviour on a dual Xeon system here. But it began
> with 2.4.22. After upgrading from 2.4.21 to 2.4.22, HT was disabled. It
> became even worse, the mainboard (some Serverworks board in Siemens
> Primergy F250 server) decided to disable the second CPU completely (I
> don't have the logs from that moment, sorry).

The problem is still reproducible with 2.4.23-rc3. And the box has
rebooted suddently after 10 days running 2.4.23-pre9 in the weird 1+2xHT
mode. After the reboot, the second CPU disappeared and now I saw that
the BIOS disabled both CPUs, maybe because of detected errors.

> After upgrading to 2.4.23-pre9 and enabling the second CPU in the
> mainboard BIOS, I see HT only working on the second CPU. There only a
> message about the first: WARNING: No sibling found for CPU 0. I tried
> compiling with or without ACPI, it makes no difference. I can live with
> 3 virtual CPUs but idealy it should be fixed before 2.4.23 release.
> Needles to say that it still works with 4 virtual CPUs using 2.4.21.
> 
> Kernel messages for those who are interessted:

Both logs from 2.4.23-pre and 2.4.21 can be found on:

http://sites.inka.de/W1752/ht-trouble.txt

MfG,
Eduard.
-- 
Abwechslung ist des Lebens Reiz, was freilich jede glückliche Ehe zu
widerlegen scheint.
		-- Theodor Fontane
