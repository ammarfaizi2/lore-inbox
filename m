Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUHTPxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUHTPxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUHTPxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:53:37 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:3557 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268224AbUHTPx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:53:27 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Terence Ripperda <tripperda@nvidia.com>
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Date: Fri, 20 Aug 2004 09:53:11 -0600
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040819092654.27bb9adf.akpm@osdl.org> <200408191603.55327.bjorn.helgaas@hp.com> <20040819225848.GE1263@hygelac>
In-Reply-To: <20040819225848.GE1263@hygelac>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408200953.11440.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 4:58 pm, Terence Ripperda wrote:
> I'll move that call to pci_enable_device to earlier in the probe call.

Thanks.

> but in Kevin's original email, he's hitting an oops within the
> pci_enable_device call. is that likely due to pci_enable_device being
> called late?

I don't seem to have an email from Kevin.  Can you forward it to
me?  The thread I know about started with mail from Michael Geithe
that Andrew Morton forwarded to me:

> kernel 2.6.8.1-mm2 booting here with acpi_os_name=Linux and pci=routeirq.
> Without pci=routeirq hangs at startx (nvidia).

I didn't see any oops there.
