Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVBOBlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVBOBlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVBOBlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:41:35 -0500
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:18352 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S261540AbVBOBld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:41:33 -0500
Subject: Re: avoiding pci_disable_device()...
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <4211013E.6@pobox.com>
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com>
	 <4211013E.6@pobox.com>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 15:02:32 -0500
Message-Id: <1108411352.5994.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2005 01:41:33.0094 (UTC) FILETIME=[7A7D9C60:01C512FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No.  You also need to consider situations such as out-of-tree drivers 
> for the same hardware (might not use PCI API), and situations where you 
> have peer devices discovered and used (PCI API doesn't have "hey, <this> 
> device is associated with <current driver>, too" capability)


there's not a lot you or anyone else can do about such broken (and often
proprietary) drivers.... if a device doesn't use the kernel API's its
end of game basically. Adding more new API's isn't going to help you ...



