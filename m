Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVG1UEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVG1UEa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVG1T6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:58:30 -0400
Received: from mail.dvmed.net ([216.237.124.58]:38603 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261565AbVG1T4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:56:31 -0400
Message-ID: <42E9386B.7040108@pobox.com>
Date: Thu, 28 Jul 2005 15:56:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Felix <gregfelixlkml@gmail.com>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata_piix.c: check PCI sub-class code before AHCI disabling
References: <e16ac85e050304160467045421@mail.gmail.com>
In-Reply-To: <e16ac85e050304160467045421@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Felix wrote:
> This patch adds functionality to check the PCI sub-class code of an
> AHCI capable device before disabling AHCI.  It fixes a bug where an
> ICH7 sata controller is being setup by the BIOS as sub-class 1 (ide)
> and the AHCI control registers weren't being initialized, thus causing
> an IO error in piix_disable_ahci().
> 
> Thanks,
> Greg Felix
> 
> 
> Signed-off-by: Gregory Felix <greg.felix@gmail.com>

Applied to 2.6.x, and uploads to 'upstream' branch of libata-dev.git.

Will apply to 2.4.x as soon as Marcelo pulls what I just submitted.

	Jeff



