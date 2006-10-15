Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWJOQmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWJOQmy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 12:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWJOQmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 12:42:53 -0400
Received: from animx.eu.org ([216.98.75.249]:32984 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1161003AbWJOQmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 12:42:53 -0400
Date: Sun, 15 Oct 2006 12:32:35 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux@horizon.com
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: IDE panic, 2.6.18
Message-ID: <20061015163235.GA402@animx.eu.org>
Mail-Followup-To: linux@horizon.com, B.Zolnierkiewicz@elka.pw.edu.pl,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061007203222.24846.qmail@science.horizon.com> <20061015162906.4270.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015162906.4270.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
> I just got a fourth panic.  Fortunately, no file system corruption
> this time.  It was an exact clone of the second one, down to the register
> contents, except for the process name, so I haven't bothered transcribing
> it separately.  Also, I wasn't messing with the drives when it happened;
> I was asleep in bed and found the panic greeting me on the morning.
> 
> I apologize for the truncated logs, but I couldn't scroll back and had
> to photograph the console screen to get what's here.
> 
> i686 uniprocessor, 440BX motherboard, 1 GB ECC memory (you can see from
> the kernel addresses that I'm using a 2.75/1.25 G memory split), has been
> in production with excellent stability for a long time.  Occasional disk
> glitches handled by RAID; almost everything except for some scratch
> space is mirrored.
> 
> Monolithic kernel.org 2.6.18 + linuxpps patches.

I had something similar to this happen to me, however, I was unable to use
the system at all once this happened.

I'm using a Supermicro X5DA8 motherboard (2x 2.6ghz xeon, 1gb mem, 3 dual
scsi controllers).  IDE is a module and as soon as hotplug loads the module
for the IDE controller, it hangs.  My boot disk is on the internal scsi ch0
controller.  The only IDE device is a single cdrom (all other drives are
scsi or use a hardware ide-to-scsi converter).  The IDE controller is an
Intel ICH4 controller (Intel E7505 chipset)

If anyone is interested, I will post my 2.6.18 config.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
