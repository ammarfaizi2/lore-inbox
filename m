Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275420AbTHNR3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275421AbTHNR3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:29:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5019 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S275420AbTHNR3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:29:34 -0400
Date: Thu, 14 Aug 2003 14:29:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@localhost.localdomain
To: Narayan Desai <desai@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 boot hang
In-Reply-To: <878ypwkz0d.fsf@mcs.anl.gov>
Message-ID: <Pine.LNX.4.44.0308141428330.3360-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Aug 2003, Narayan Desai wrote:

> We have a netfinity 5100 (including aic7xxx scsi controllers) that
> fails to boot with kernels newer than 2.4.18. The last few lines in
> the boot messages are:
> hda: LTN485S, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-cdrom driver.
> hda: ATAPI 48X CD-ROM drive, 120kB Cache
> Uniform CD-ROM driver Revision: 3.12
> SCSI subsystem driver Revision: 1.00
> 
> After this point, the system has locked up. (sysrqs don't work, etc)
> The system is a dual pIII. acpi is disabled. This machine has worked
> stably with 2.4.14 and 2.4.18 for quite a while. (it is a fileserver,
> and isn't touched often)
> 
> I have tried running with noapic, to no avail. I have attached
> complete boot messages and .config. How can i get more info out about
> where it is dying?

Do you have the NMI watchdog on? If not please turn it on, it should give
us useful information.

