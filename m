Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVELVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVELVXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVELVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 17:23:46 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43984 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262131AbVELVXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 17:23:31 -0400
Message-ID: <4283C949.3050503@pobox.com>
Date: Thu, 12 May 2005 17:23:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Istead <jistead@nuvation.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: non-PCI libata
References: <FC3C0DD86B79DF4FA423AF0379A54761029DD0EA@mailguy2.nuvation.com>
In-Reply-To: <FC3C0DD86B79DF4FA423AF0379A54761029DD0EA@mailguy2.nuvation.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Istead wrote:
> Hello,
> 
> I have a question related to an LKML post on April 5, 2005:
> 
> http://lkml.org/lkml/2005/4/5/210
> 
> Preamble:
> I'm developing a low level driver for a non-PCI AHCI controller.  In
> particular, I'm using uClinux (2.6.x kernel) on a Nios II processor (Avalon
> bus, etc etc).  
> 
> It looks like porting "drivers/scsi/ahci.c" to uClinux is the easiest way to
> do this.  However, ahci.c depends on libata, and both of these are littered
> with PCI-specific calls.
> 
> Question:
> Is there a non-PCI libata (or, are there plans to make one)?

libata already supports non-PCI.  Another engineer is already using 
libata on his embedded non-PCI hardware.

You'll just have to modify AHCI to support non-PCI.

	Jeff


