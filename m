Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVB1G6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVB1G6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 01:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVB1G6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 01:58:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:18076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261498AbVB1G6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 01:58:09 -0500
Date: Sun, 27 Feb 2005 22:57:52 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [ patch 1/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050228065752.GD23595@kroah.com>
References: <422259EF.90104@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422259EF.90104@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 06:38:23PM -0500, Wen Xiong wrote:
> +static struct pci_device_id jsm_pci_tbl[] = {
> +	{	DIGI_VID, PCI_DEVICE_NEO_4_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,		0 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_8_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,		1 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2DB9_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	2 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2DB9PRI_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	3 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2RJ45_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	4 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2RJ45PRI_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	5 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_1_422_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	6 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_1_422_485_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	7 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2_422_485_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	8 },

Use the PCI_DEVICE() macro to make this smaller.

thanks,

greg k-h
