Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbUC2Ilc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUC2Ilc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:41:32 -0500
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:11430 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S262764AbUC2Ila (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:41:30 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: usage of RealTek 8169 crashes my Linux system
Date: Mon, 29 Mar 2004 09:41:27 +0100
User-Agent: KMail/1.6.1
Cc: Jeff Garzik <jgarzik@pobox.com>, silverbanana@gmx.de
References: <40673495.3050500@gmx.de> <4067378B.7070102@pobox.com>
In-Reply-To: <4067378B.7070102@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403290941.27765.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 28 March 2004 21:37, Jeff Garzik wrote:
> Bernd Fuhrmann wrote:
> >
> > Any idea how to fix it? Is that driver getting stable in the next months
> > or are there obstacles that should make me buy a different NIC (like
> > missing docs for that chipset and stuff like that)?
>
> Does Andrew Morton's -mm patches fix it for you?
>
> 	Jeff


 Hi,

  I'm also seeing hard crashes when using the r8169 driver, running a 32-bit 
2.6.4-rc1 kernel on a AMD64 system with a MSI K8T motherboard (VIA KT800). It 
has an onboard Realtek 8110S chip.
  When I stopped using the r8169 module the crashes stopped. Now using a PCI 
rtl8139 nic temporarily.

  Is there any way to apply these newer -netdev patches without resorting to 
-mm tree? This is a production machine, so I'd rather stick to linus' 2.6.x, 
but if there's no choice I'll try -mm...

 Thanks in advance for your attention.

Claudio

