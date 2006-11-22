Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031442AbWKVBEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031442AbWKVBEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031431AbWKVBEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:04:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:37457 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031425AbWKVBEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:04:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RrNqhkyIAMLlBs0VaxObpHZi1SNw7sr0WVgOXi0Z/RTvIDtqdEiK8RlIy9F+UMpn157Eq+4byXRzzl/z3MpwHEQ7RsUjQaen6wCsWTgP+kv7Hb5lBfSLYgyjxTqwRniLSc83EkrBuHzlDbMIJzrQWyflJkNLWzHgFIBr5DZMNPM=
Message-ID: <4563A203.1080707@gmail.com>
Date: Wed, 22 Nov 2006 10:04:03 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Jason Gaston <jason.d.gaston@intel.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
References: <1164149498.27730.17.camel@localhost.localdomain>
In-Reply-To: <1164149498.27730.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gaston wrote:
> This patch adds the Intel ICH9 AHCI controller DID's for SATA support.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.19-rc6/drivers/ata/ahci.c.orig	2006-11-20
> 04:56:51.000000000 -0800
> +++ linux-2.6.19-rc6/drivers/ata/ahci.c	2006-11-20 04:58:30.000000000
> -0800

Again, wrapped.

> @@ -314,6 +314,17 @@
>  	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
>  	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
>  	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
> +	{ PCI_VDEVICE(INTEL, 0x2922), board_ahci }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2923), board_ahci }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
> +	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
>  
>  	/* JMicron */
>  	{ PCI_VDEVICE(JMICRON, 0x2360), board_ahci }, /* JMicron JMB360 */

Other than that, looks fine.

-- 
tejun
