Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbWIMBXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWIMBXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWIMBXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:23:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5252 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030474AbWIMBXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:23:02 -0400
Message-ID: <45075D73.5030005@garzik.org>
Date: Tue, 12 Sep 2006 21:22:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Michael Tokarev <mjt@tls.msk.ru>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Vendor field with USB, [SP]ATA etc-attached disks
References: <4505A612.8070603@tls.msk.ru> <4505BA2B.1020105@garzik.org> <4506AB4B.9010801@gmail.com>
In-Reply-To: <4506AB4B.9010801@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> For the time being, we'll have to live with boilerplate ATA vendor and 
> truncated vendor ID.  There are plans to make libata independent from 

Truncated model ID, I presume you mean.


> SCSI which should solve the problem but it will take quite some time.

Since ATA does not distinguish between vendor and model, you can't 
really solve the problem.  Two high volume disk vendors don't bother to 
put a vendor name in the model string at all.

	Jeff



