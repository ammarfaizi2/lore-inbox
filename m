Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUEDI20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUEDI20 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 04:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUEDI20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 04:28:26 -0400
Received: from pop.gmx.de ([213.165.64.20]:57531 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264260AbUEDI2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 04:28:22 -0400
X-Authenticated: #4512188
Message-ID: <40975423.5090708@gmx.de>
Date: Tue, 04 May 2004 10:28:19 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Ross Dickson <ross@datscreative.com.au>,
       Len Brown <len.brown@intel.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com> <200405040111.01514.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405040111.01514.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 04 of May 2004 00:09, Allen Martin wrote:
> 
>>I'm happy to be able to make this information public to the Linux
>>community.  This information has been previously released to BIOS /
>>board vendors as an appnote, but in the interest of getting a workaround
>>into the hands of users the quickest we're making it public for possible
>>inclusion into the Linux kernel.
> 
> 
> This is a great news!  Below is an untested patch to address this issue.
> 

Yes it works!!!! Finally the nforce2 issue has been fixed. I still can't 
believe it.

Dear Allen, it is nice that after all Nvidia decided to give out 
information about this issue. I would have been so nice, if this had 
been doen about 6 months ago, where I originally discovered the 
connection between apic instability and cpu disconnect. But I guess I 
shouldn't scold Nvidia but the mainboard manufacturers who were still 
sleeping, like in my case: Abit. Till today the didn't manage to fix 
this issue and the timer issue (and they released a new bios a few days 
ago...)

Maybe Nvidia should scold the board manufacturers to keep their bioses 
updated. After all it is Nvidia getting a bad image if everybody thinks 
"Nvidia boards are unstable and they don't care to resplve it." So it 
would be in Nvidia's own interest to push the manufacturers to integrate 
such critical fixes ASAP.

The only issues left for me are

a) semi-stable nvidia binary driver
b) higher idle temperature with nvidia driver (I guess). I may also be a 
sensors probelm as Abit's reading is known as not to be very precise and 
read something else after every reboot thanks to new recalibration.
c) missing driver for nforce2 apu...

Thanx after all.

Prakash
