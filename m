Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbUKQIFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUKQIFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUKQIFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:05:17 -0500
Received: from [81.3.11.18] ([81.3.11.18]:22246 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S262136AbUKQIEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:04:21 -0500
Date: Wed, 17 Nov 2004 09:04:17 +0100
From: Konstantin Kletschke <lists@ku-gbr.de>
To: linux-kernel@vger.kernel.org
Subject: Re: acpi_power_off issue in 2.6.10-rc2-mm1
Message-ID: <20041117080416.GA7897@ku-gbr.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0411162301460.5829@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411162301460.5829@student.dei.uc.pt>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2004-11-16 23:10 +0000 schrieb Marcos D. Marado Torres:
> 
> Greetings,
> 
> In 2.6.10-rc2 and previous kernels acpi_power_off allways worked fine, but in
> 2.6.10-rc2-mm1 when I do 'halt' all runs fine, the last message "acpi_power_off
> called. System is going to power off" (something like this, I don't recall
> ^-^;) appears, but then the machine just doesn't power off.

Funny, I encountered this problem on two Computers having an SIS
K7S5A[PRO] mainboard on

Linux zappa 2.6.10-rc1-mm5 #2 Sat Nov 13 17:17:40 CET 2004 i686
GNU/Linux

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev
01)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual
PCI-to-PCI bridge (AGP)
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513
(LPC Bridge)

The systems shuts down and spins the hdds off. But the "main" power
goes not down.

Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
