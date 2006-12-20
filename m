Return-Path: <linux-kernel-owner+w=401wt.eu-S964873AbWLTEUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWLTEUn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 23:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWLTEUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 23:20:43 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62631 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964873AbWLTEUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 23:20:43 -0500
Date: Tue, 19 Dec 2006 22:20:30 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 3/4] Add driver for OHCI firewire host controllers.
In-reply-to: <fa.4xX+iXSBwItlW4ONHWvAYR6m5+c@ifi.uio.no>
To: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Message-id: <4588BA0E.1080801@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 8BIT
References: <fa.4xX+iXSBwItlW4ONHWvAYR6m5+c@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Signed-off-by: Kristian Hoegsberg <krh@redhat.com>
> ---
>  drivers/firewire/Kconfig   |   11 
>  drivers/firewire/Makefile  |    1 
>  drivers/firewire/fw-ohci.c | 1394 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/firewire/fw-ohci.h |  152 +++++
>  4 files changed, 1558 insertions(+), 0 deletions(-)
> 

..

> +static struct pci_driver fw_ohci_pci_driver = {
> +	.name		= ohci_driver_name,
> +	.id_table	= pci_table,
> +	.probe		= pci_probe,
> +	.remove		= pci_remove,
> +};

How about suspend/resume support? Lots of laptops have OHCI 1394 and 
full suspend/resume support is something that the current ohci1394 
driver lacks.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

