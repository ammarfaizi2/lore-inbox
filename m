Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbULTXyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbULTXyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULTXyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:54:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:12694 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261709AbULTXon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:44:43 -0500
Message-ID: <41C75E8B.1020200@osdl.org>
Date: Mon, 20 Dec 2004 15:21:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: Attila BODY <compi@freemail.hu>, linux-kernel@vger.kernel.org
Subject: Re: USB storage (pendrive) problems
References: <1103579679.23963.14.camel@localhost> <200412202325.20064.andrew@walrond.org>
In-Reply-To: <200412202325.20064.andrew@walrond.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> On Monday 20 December 2004 21:54, Attila BODY wrote:
> 
>>Hi,
>>
>>I have some weird problems with my pendrives recently. I just compile a
>>2.6.9 to check if the problem is still exists there.
>>
>>current kernel is 2.6.10-rc3 and the situation is the following:
>>
>>If I copy more than few megabytes to the drive, the activity LED keeps
>>flashing forever. sync, umount keeps runing forever, normal reboot is
>>inpossible (alt+sysreq+b seems to work)
>>
>>Tested with usb 1.1 and 2.0 pendrives, behaviour is the same.
>>
> 
> 
> I'm doing exactly that with 2.6.10-rc3. umount does take a very long time (but 
> I had just written 600Mb+ over usb 1.1)
> 
> Are you sure it doesn't come back if you leave it long enough?
> 
> Do the throughput sums; you'll be suprised how long it takes to send more than 
> a few Mb over usb 1.1 (1.5Mb/s). Eg 600Mb = 7minutes
> 
> Usb 2 should be much faster; Do you have EHCI loaded?

and which usb driver are you using?
ub or usb-storage?  (what's the /dev name that you mount?)

-- 
~Randy
