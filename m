Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUBXBIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUBXBH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:07:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36032 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262136AbUBXBGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:06:53 -0500
Message-ID: <403AA3A1.5050206@pobox.com>
Date: Mon, 23 Feb 2004 20:06:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Boszormenyi Zoltan <zboszor@freemail.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise TX2plus PATA port?
References: <4039B8AF.9060002@freemail.hu>
In-Reply-To: <4039B8AF.9060002@freemail.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan wrote:
> how can I make it work? The BIOS recognizes the drive
> (jumpered as master) but 2.6.3-mm2 does not. Device id is 0x3373.
> pdc202xx_new, pdc202xx_old and sata_promise drivers
> are compiled in. Motherboard is an MSI K8T Neo FIS2R.
> The 120GB Samsung and the Sony CRX300E DVD/CDRW combo
> are recognized by both the BIOS and the kernel.


I (or somebody) needs to add PATA support for that device. 
Unfortunately they put both PATA and SATA on the same PCI device.

	Jeff



