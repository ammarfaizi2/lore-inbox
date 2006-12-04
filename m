Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937095AbWLDQ16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937095AbWLDQ16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937096AbWLDQ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:27:58 -0500
Received: from mail.syneticon.net ([213.239.212.131]:52959 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937093AbWLDQ14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:27:56 -0500
Message-ID: <45744C75.7080808@wpkg.org>
Date: Mon, 04 Dec 2006 17:27:33 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH]: via 6421 PATA support done in a rather cleaner fashion
References: <45742FFA.6020604@wpkg.org> <20061204152105.6132a59c@localhost.localdomain>
In-Reply-To: <20061204152105.6132a59c@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Wants testing... so test and report
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> --- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/sata_via.c	2006-11-24 13:58:05.000000000 +0000
> +++ linux-2.6.19-rc6-mm1/drivers/ata/sata_via.c	2006-12-04 14:57:34.719099648 +0000

PATA works fine with this patch, great.


Being on sata_via subject - why did it start to appear in 2.6.19 kernel 
(even without any pata patch)?

# rmmod sata_via
ata6.00: disabled
Synchronizing SCSI cache for disk sdb:
FAILED
   status = 0, message = 00, host = 4, driver = 00


Other sata modules I tried unload fine.


-- 
Tomasz Chmielewski
http://wpkg.org
