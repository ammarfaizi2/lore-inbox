Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264925AbUEVJKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUEVJKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 05:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbUEVJKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 05:10:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37767 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264925AbUEVJKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 05:10:18 -0400
Message-ID: <40AF18E7.4040509@pobox.com>
Date: Sat, 22 May 2004 05:09:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.6.6-mm5
References: <20040522013636.61efef73.akpm@osdl.org>
In-Reply-To: <20040522013636.61efef73.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> - Added a new SATA RAID driver from 3ware.  From a quick peek it seem to
>   need a little work yet.


It's not too bad... but it looks more like a 2.2 driver forward ported 
to 2.4, than a 2.6.x driver.  Needs some luvin' from the 2.6 scsi api crew.

Overall, it appears to be a message-based firmware engine like 
drivers/block/carmel.c, that hides the SATA details in the firmware.

	Jeff


