Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWGNQtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWGNQtK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWGNQtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:49:09 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:17899 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1422642AbWGNQtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:49:08 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.2
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, greg@kroah.com, harmon@ksu.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <44B7C521.5080009@gentoo.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
	 <20060714154240.GA23480@tuatara.stupidest.org>
	 <44B7C37F.1050400@gentoo.org>  <44B7C521.5080009@gentoo.org>
Content-Type: text/plain; charset=utf-8
Date: Fri, 14 Jul 2006 17:48:54 +0100
Message-Id: <1152895734.11043.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 17:24 +0100, Daniel Drake wrote:
> Daniel Drake wrote:
> > It is worth noting that on the Gentoo bug report, the user could not 
> > boot from VIA SATA while that ID was not in the list. However, if the 
> > ACPI was *disabled* then the system booted fine (even without the SATA 
> > ID in the list, i.e. no quirk applied).
> > 
> > This suggests that the quirk is only needed for ACPI users, at least on 
> > that system.
> 
> I just confirmed this on my own system, at least partially. I removed 
> the quirk and the system booted fine.
> 
> This is with ACPI enabled, but APIC not enabled (hence the interrupts 
> are XT-PIC). I cannot enable APIC on this system due to buggy BIOS.
> 
> Daniel

Daniel, VIA_SATA is not in the list , so when you write remove , you
remove what ? or you want say the opposite ?  
Please rephrase your sentence .

Do you need quirk SATA with acpi=off  ?

Do you need quirk with ACPI enabled ? 

Sérgio M. B. 

