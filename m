Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946698AbWKAIOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946698AbWKAIOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946697AbWKAIOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:14:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34176 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946695AbWKAIOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:14:37 -0500
Subject: Re: [PATCH 1/2] sata_nv: Add nvidia SATA controllers of MCP67
	support to sata_nv.c
From: Arjan van de Ven <arjan@infradead.org>
To: Peer Chen <pchen@nvidia.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C54F43D@hkemmail01.nvidia.com>
References: <15F501D1A78BD343BE8F4D8DB854566B0C54F43D@hkemmail01.nvidia.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 01 Nov 2006 09:14:31 +0100
Message-Id: <1162368871.3044.77.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 15:23 +0800, Peer Chen wrote:
> Add support for SATA controllers of MCP67.
> The patch will be applied to kernel 2.6.19-rc4-git1.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>
> 
> =============================================
> --- linux-2.6.19-rc4-git1/drivers/ata/sata_nv.c.orig	2006-10-31
> 20:44:45.000000000 +0800
> +++ linux-2.6.19-rc4-git1/drivers/ata/sata_nv.c	2006-11-01
> 00:14:48.000000000 +0800
> @@ -117,10 +117,14 @@ static const struct pci_device_id nv_pci
>  	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA),
> GENERIC },

your patch is still word-wrapped!


