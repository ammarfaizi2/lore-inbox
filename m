Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269645AbTGJWHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbTGJWG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:06:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269589AbTGJWGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:06:21 -0400
Message-ID: <3F0DE6C2.5030608@pobox.com>
Date: Thu, 10 Jul 2003 18:20:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: FW: cciss updates for 2.4.22-pre3  [5 of 6]
References: <D4CFB69C345C394284E4B78B876C1CF104052A67@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF104052A67@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miller, Mike (OS Dev) wrote:
> @@ -2506,11 +2512,6 @@
>  	(void) pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, 
>  						&board_id);


This line _still_ needs to be removed.

Use the 'subsystem_vendor' and 'subsystem_device' members of struct 
pci_dev instead.

	Jeff



