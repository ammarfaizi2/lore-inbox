Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752088AbWFWVcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbWFWVcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbWFWVcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:32:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:4019 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752088AbWFWVcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:32:07 -0400
Message-ID: <449C5DD4.9080604@garzik.org>
Date: Fri, 23 Jun 2006 17:32:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Chew <AChew@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add MCP65 support for sata_nv driver
References: <DBFABB80F7FD3143A911F9E6CFD477B00604CEB4@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00604CEB4@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
>> Why do you want to remove the RAID PCI ID?  That was not mentioned in 
>> the patch description at all.
> 
> Sorry.  NVIDIA's future SATA controllers are going to be AHCI (so for
> 0104 RAID mode, we want the ahci driver to pick up these controllers.
> We don't want future chips (chips for which we didn't add the proper
> device IDs yet into their respective drivers) to be picked up by sata_nv
> anymore.
> 
> What's missing, I realize now, is the 0104 generic entry that should be
> in the ahci driver.  I'll send along a separate patch for that.

I dropped the RAID-id-removal bit from the patch I forwarded to you, so 
you'll want to resend that.  Perhaps resend it in the same patch as the 
ahci bit, and include what you said above, in the description.

	Jeff



