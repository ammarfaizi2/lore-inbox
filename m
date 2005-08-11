Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVHKRrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVHKRrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVHKRrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:47:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:5543 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932309AbVHKRrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:47:08 -0400
Message-ID: <42FB8F0D.6060202@pobox.com>
Date: Thu, 11 Aug 2005 13:46:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: Lee Revell <rlrevell@joe-job.com>, lgb@lgb.hu,
       Allen Martin <AMartin@nvidia.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>	 <20050811070943.GB8025@vega.lgb.hu> <1123765523.32375.10.camel@mindpipe> <42FB6C27.1010408@gmail.com> <42FB88F8.7040807@pobox.com> <42FB8D04.8050006@gmail.com>
In-Reply-To: <42FB8D04.8050006@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> I have a ASUS A8V Deluxe too, and can't use the AMD X2 processor on 
> it...this is a feature..right?
> Supposed to run with DualCore but don't post..hm.

What does ASUS say about this?  You can't just plug a new processor into 
an old motherboard and expect it to work, generally.


> My SATA II devices. Get not regonized from the VIA SATA 
> controller...this bug is known.
> So I want to use my HDD's I bought ...why should I set my SATA II device 
> to be SATA I.

Please enable ATA_DEBUG and ATA_VERBOSE_DEBUG, and send me the output.

SATA II devices can be used on SATA I controllers just fine, with no 
need to tweak settings.

	Jeff



