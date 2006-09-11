Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWIKPdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWIKPdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWIKPdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:33:11 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:32204 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751296AbWIKPdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:33:09 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Stian Jordet <liste@jordet.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       akpm@osdl.org, torvalds@osdl.org, jeff@garzik.org, greg@kroah.com,
       cw@f00f.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       harmon@ksu.edu, len.brown@intel.com, vsu@altlinux.ru
In-Reply-To: <1157916102.21295.9.camel@localhost.localdomain>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <450436F1.8070203@gentoo.org>
	 <1157906395.23085.18.camel@localhost.localdomain>
	 <4504621E.5090202@gentoo.org>
	 <1157917308.23085.26.camel@localhost.localdomain>
	 <1157916102.21295.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Sep 2006 16:33:29 +0100
Message-Id: <1157988809.13889.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 21:21 +0200, Stian Jordet wrote:
> On søn, 2006-09-10 at 20:41 +0100, Alan Cox wrote:
> > Feel free to cc me the lspci data and partial diagnostics and I'll try
> > and help too.
> 
> Attached is lspci -xxx and dmesg from 2.6.18-rc6.
> http://bugzilla.kernel.org/show_bug.cgi?id=2874 has some further
> information about this (stupid) motherboard. Anything else you need?
> 
> If anyone can help me with this, I'll promise to send the hero some
> boxes of Norwegian beer!
> 
> 
Hi, this isn't the case of one USB with IO-APIC-level on legacy
interrupts ? 
 11:       5333       5326   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3

if it is , was resolved with this [PATCH V3] VIA IRQ quirk behaviour change ? 

Thanks,
--
Sérgio M. B. 

