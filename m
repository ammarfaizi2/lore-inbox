Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbTLRR2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 12:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbTLRR2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 12:28:47 -0500
Received: from lists.us.dell.com ([143.166.224.162]:40663 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265245AbTLRR2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 12:28:45 -0500
Date: Thu, 18 Dec 2003 11:28:41 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Gonzalo Coello <gonzalocoello@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Not able to load megaraid module after kernel upgrade from 2.4.9-e2 to 2.4.9-e25
Message-ID: <20031218112841.A4402@lists.us.dell.com>
References: <BAY2-F77LwSQcBqfrft00040881@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BAY2-F77LwSQcBqfrft00040881@hotmail.com>; from gonzalocoello@hotmail.com on Thu, Dec 18, 2003 at 04:54:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello I am running dell Power Edge 12600, with Firmware 1.68,
> I have a Perc 4/Si RAID Controller BIOS version 1.04 FW 2.27 (the last 
> version)
> When starting up, the bios can recognize the disk array with no problem, the 
> server starts booting OK, but when it gets to load the megaraid module, it 
> brakes:

The Linux-PowerEdge@dell.com list may be more appropriate for this
type of question.  Subscribe at http://lists.us.dell.com/.

For the Red Hat kernel you mention, you want /etc/modules to list the
megaraid_2002 driver, not plain megaraid.  Then remake your initial
ramdisk such that the megaraid_2002 driver gets picked up and used at
next boot.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
