Return-Path: <linux-kernel-owner+w=401wt.eu-S1030462AbXAHCtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbXAHCtc (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 21:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbXAHCtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 21:49:32 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51751 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030462AbXAHCtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 21:49:31 -0500
Message-ID: <45A1B137.9070306@garzik.org>
Date: Sun, 07 Jan 2007 21:49:27 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Pablo Sebastian Greco <lkml@fliagreco.com.ar>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA problems
References: <459A674B.3060304@fliagreco.com.ar> <459B9F91.9070908@gmail.com> <459BC703.9000207@fliagreco.com.ar> <459C8A5E.5010206@gmail.com> <459CFE7B.6090306@fliagreco.com.ar> <459DC2EE.1090307@fliagreco.com.ar> <45A1AB3F.1080408@gmail.com>
In-Reply-To: <45A1AB3F.1080408@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Pablo Sebastian Greco wrote:
>> After an uptime of  13:34 under heavy load and no errors, I'm pretty
>> sure your patch is correct. Is there a way to backport this to 2.6.18.x?
> 
> I forgot this (even though I implemented it) but you can turn off NCQ by
> doing the following.
> 
> # echo 1 > /sys/block/sdX/device/queue_depth

Thanks, I had forgotten this, too :)

Added to the libata FAQ: http://linux-ata.org/faq.html

	Jeff


