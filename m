Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUFVPjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUFVPjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbUFVPfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:35:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5102 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264970AbUFVPe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:34:57 -0400
From: "Garreth Jeremiah" <gin@ginandtonic.ca>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Don't want to share interrupts
Date: Tue, 22 Jun 2004 11:30:21 -0400
Message-ID: <000001c4586d$d5076e10$0c501709@IBM3B3C778F126>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <40D83EE8.6090700@pobox.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jeff (quick response)

> > IRQs are assigned by firmware.  Try turning on/off io-apic or ACPI.

If IRQ's are assigned by firmware then why does Windows 2K3 assign an
IRQ per port and Linux not?

If I can get Linux to assign 1 IRQ per Ethernet port then my system will
magically work (it does under Win2K3).

So, I am asking if there is a way to assign 1 IRQ per Ethernet port in
the same manner as Windows? 

I have a service call in with IBM to see if there is a way I can change
from MP1.4 to MP1.1 as suggested in the SMP-HOWTO (there is no menu
option for this) and then I can use the noapic/acpi=no options, but I'd
rather not as this will limit the number of IRQ's available.

Many thanks,

(FYI no additional information has been posted because I can not get
into the machine across the network without these interfaces in order to
retrieve the files suggested in REPORTING-BUGS) and there is no floppy
permitted.


