Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUIAITu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUIAITu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUIAITt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:19:49 -0400
Received: from main.gmane.org ([80.91.224.249]:16334 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263001AbUIAIRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:17:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: Linux 2.6.8.1-ac1
Date: Wed, 01 Sep 2004 11:17:45 +0300
Message-ID: <pan.2004.09.01.08.17.41.824046@yahoo.com>
References: <20040831170839.GA18799@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 194.196.100.133
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I will try this patch on an IBM T41 Thinkpad, and I am interested in its
IDE Hotplug functionality.
Will I be able to swap IDE devices in my ultrabay without using "idectl 1
rescan" (using this patch only) ?
Do I need any other special tool for ide hotswapping in this case?
Or should I wait for IDE hotplug at the device level ?

Thanks,
Paul

On Tue, 31 Aug 2004 13:08:39 -0400, Alan Cox wrote:

> I've posted up a 2.6.8.1-ac1. This is mostly aimed at people wanting to
> try the newer IDE stuff while I work on feeding it to Bartlomiej.
> 
> http://www.kernel.org/pub/linux/kernel/people/alan/2.6/linux-2.6/2.6.8.1/..
> 
> Change summary for Linux 2.6.8.1-ac1 versus 2.6.8.1
> 
> [ * = submitted to maintainer, + = submitted but needs more work ]
> 
> *	Fix crash on boot or nonworking keyboard driver		(Alan Cox)
> 		with E750x based systems in SMP
> *	Fix timing violation in i8042 driver code		(Alan Cox) *	Allow 3% slack
> for root in strict overcommit		(Alan Cox) *	Add support for 16byte (GPRS)
> pcmcia serial cards	(Alan Cox) *	Reformat buslogic ready for real fixing		
> (indent) *	Support VLAN on 3c59x/3c90x hardware		(Stefan de Konkink) *
> Serial ATA reporting of ATA errors for real diagnostics	(Alan Cox) +	Fix
> IDE locking, /proc races and other uglies		(Alan Cox) +	Initial IT8212 IDE
> driver				(Alan Cox) +	IDE hotplug (controller level)				(Alan Cox) +	Fix
> IDE disk crash on bad geometry			(Alan Cox) +	Fix mishandling of pure LBA
> devices			(Alan Cox) +	Fix problems with non-decoded slaves			(Alan Cox) -
> Fix failure to handle large drives on ALi controllers	(Alan Cox)
> 	| Lost from 2.4-ac to 2.6.
> -	Initial code working at making jiffies removal easier	(Alan Cox)


