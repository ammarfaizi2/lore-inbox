Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWHRGPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWHRGPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWHRGPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:15:51 -0400
Received: from msr20.hinet.net ([168.95.4.120]:62125 "EHLO msr20.hinet.net")
	by vger.kernel.org with ESMTP id S1750704AbWHRGPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:15:50 -0400
Message-ID: <02f601c6c28d$b9986f30$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>,
       <jgarzik@pobox.com>
References: <1155841247.4532.6.camel@localhost.localdomain> <20060817151945.GC5205@martell.zuzino.mipt.ru>
Subject: Re: [PATCH 1/6] IP100A, add end of pci id table
Date: Fri, 18 Aug 2006 14:15:38 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey:

I will remove that. Thanks for that.

Jesse Huang

----- Original Message ----- 
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<akpm@osdl.org>; <jgarzik@pobox.com>
Sent: Thursday, August 17, 2006 11:19 PM
Subject: Re: [PATCH 1/6] IP100A, add end of pci id table


On Thu, Aug 17, 2006 at 03:00:47PM -0400, Jesse Huang wrote:
> Add "0," and "NULL," to sundance_pci_tbl and pci_id_table.

> @@ -212,7 +212,7 @@ static const struct pci_device_id sundan
>  { 0x1186, 0x1002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
>  { 0x13F0, 0x0201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 },
>  { 0x13F0, 0x0200, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6 },
> - { }
> + { 0,}
>  };
>  MODULE_DEVICE_TABLE(pci, sundance_pci_tbl);
>
> @@ -231,7 +231,7 @@ static const struct pci_id_info pci_id_t
>  {"D-Link DL10050-based FAST Ethernet Adapter"},
>  {"Sundance Technology Alta"},
>  {"IC Plus Corporation IP100A FAST Ethernet Adapter"},
> - { } /* terminate list. */
> + { NULL,} /* terminate list. */

They are already properly terminated. You don't have to do anything.


