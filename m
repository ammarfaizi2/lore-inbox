Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269647AbTGJWHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269649AbTGJWHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:07:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15061 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269647AbTGJWHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:07:44 -0400
Message-ID: <3F0DE716.5040206@pobox.com>
Date: Thu, 10 Jul 2003 18:22:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: FW: cciss updates for 2.4.22-pre3  [5 of 6]
References: <D4CFB69C345C394284E4B78B876C1CF104052A67@cceexc23.americas.cpqcorp.net> <3F0DE6C2.5030608@pobox.com>
In-Reply-To: <3F0DE6C2.5030608@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Miller, Mike (OS Dev) wrote:
> 
>> @@ -2506,11 +2512,6 @@
>>      (void) pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, 
>>                          &board_id);
> 
> 
> 
> This line _still_ needs to be removed.
> 
> Use the 'subsystem_vendor' and 'subsystem_device' members of struct 
> pci_dev instead.

LOL -- your final mail (patch 6) was delayed.

All good.

	Jeff



