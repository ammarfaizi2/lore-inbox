Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265121AbUFRLhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbUFRLhq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUFRLhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:37:45 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:28033 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S265121AbUFRLhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:37:34 -0400
From: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
Organization: TU Dresden - Operating System Group 
To: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: ACPI S3 - USB resume problem (kernel 2.6.7)
Date: Fri, 18 Jun 2004 13:41:39 +0200
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
References: <200406171744.29244.cr7@os.inf.tu-dresden.de> <200406172123.38043@zodiac.zodiac.dnsalias.org>
In-Reply-To: <200406172123.38043@zodiac.zodiac.dnsalias.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406181341.39546.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thanks Alex. You're right - the e1000 doesn't work too.
Also all other PCI-devices like firewire, USB and soundcard do not.
So it's not a problem of USB, but of ACPI-PCI.

After reading a few mails of the acpi-mailinglist and some bug reports, I know 
now, I'm not alone with this problem :/

I'll have a closer look to acpi-list & bug reports. 
Maybe someone here, has found a solution or has some hints what to do next ???

Regards,
Carsten


Am Donnerstag, 17. Juni 2004 21:23 schrieb Alexander Gran:
> Am Donnerstag, 17. Juni 2004 17:44 schrieb Carsten Rietzschel:
> > Noticed that in /proc/interrupts the values for uhci_hcd are not
> > incremented after resume. So are no IRQs where received (is that right
> > ?). What could be reason ?
>
> No Idea. I also tried to get this working, without success (And no more
> time at the moment to dig deeper). The e1000 driver has the same problem.
> No Interrupts on RX. Someone suggested to "Hook the driver to the timer
> interrupt and see if that works at least somehow", however I'm unsure how
> to do that ;)
>
> regards
> Alex
