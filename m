Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTFYWzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTFYWy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:54:59 -0400
Received: from relay1.enom.com ([66.150.5.205]:30483 "EHLO Relay1.enom.com")
	by vger.kernel.org with ESMTP id S265152AbTFYWyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:54:53 -0400
Message-ID: <20030625160902-146400041>
Message-ID: <3EFA2B83.3090305@homemail.com>
Date: Thu, 26 Jun 2003 09:08:51 +1000
From: "D. Sen" <dsen@homemail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vaxerdec@frontiernet.net
Subject: Re: ide-scsi on 2.4.21 (on IBM Thinkpad T30)
References: <3EF753EC.9080807@homemail.com>
In-Reply-To: <3EF753EC.9080807@homemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2003 23:09:03.0553 (UTC) FILETIME=[C5167310:01C33B6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have ide-scsi built as a module though?

I use hdc=ide-scsi (or hdc=scsi) as a boot parameter too. But the 
difference seems to be whether you have ide-scsi built as a module or 
into the kernel. The reason I think I chose to have it as a module all 
these years (on previous thinkpads as well) was so I could remove the 
module and swap the dvd/cd-rw for another device.

I haven't had a problem with this configuration(hdc=ide-scsi and loading 
the module through modules.conf) with any of the previous stable 
releases of the kernel (pre 2.4.21.)

Scott McDermott wrote:

 >I probably have the same CD-RW that you do (in the T30) and
 >I just use hdc=ide-scsi on kernel command line, no need for
 >manually loading. Works fine but don't try burning with
 >magicdev running :)

D. Sen wrote:
> Kernel 2.4.21 causes hangs and/or ooops during boot up if I have a 
> "probeall scsi_hostadapter ide-scsi" in my /etc/modules.conf. If I take 
> out that line and manually load the module after the laptop has booted, 
> everything is fine.
> 
> There were no such problems in 2.4.20 or earlier kernels.
> 
> Please cc me any responses as I am not on the mailing list.
> 
> DS
> 

-- 
---------------------------------------
D. Sen,
21 Woodmont Drive
Randolph
NJ 07869
Home Email: dsen@homemail.com   Tel: 973 216 2326
Work Email: dsen@ieee.org       Web: http://www.auditorymodels.org/~dsen


