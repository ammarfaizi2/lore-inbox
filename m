Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269873AbUJHMIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269873AbUJHMIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269889AbUJHMIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:08:50 -0400
Received: from magic.adaptec.com ([216.52.22.17]:65202 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S269873AbUJHMIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:08:47 -0400
Message-ID: <41668346.6090109@adaptec.com>
Date: Fri, 08 Oct 2004 08:08:38 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: "J.A. Magallon" <jamagallon@able.es>, Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
References: <1097178019.24355.39.camel@localhost> <1097188963l.6408l.2l@werewolf.able.es> <41661013.9090700@cybsft.com>
In-Reply-To: <41661013.9090700@cybsft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2004 12:08:46.0078 (UTC) FILETIME=[8FCBC1E0:01C4AD2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> J.A. Magallon wrote:
> 
>>
>> On 2004.10.07, Dave Hansen wrote:
>>
>>> I just booted 2.6.9-rc3-mm3 and got the good ol'
>>> VFS: Cannot open root device "sda2" or unknown-block(0,0)
>>> Please append a correct "root=" boot option
>>> Kernel panic - not syncing: VFS: Unable to mount root fs on
>>> unknown-block(0,0)
>>>
>>> backing out bk-scsi.patch seems to fix it.  I believe this worked in
>>> 2.6.9-rc3-mm2.
>>>
>>
>> Mine works:
>>
>> 03:0c.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
>>
>> werewolf:~> uname -a
>> Linux werewolf.able.es 2.6.9-rc3-mm3 #1 SMP...
> 
> 
> Mine doesn't without backing out those patches :) See my other post 
> about this.
> 
> 04:05.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 04:05.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

You can see you have different chips.  It's the IDs.
I'll come up with something shortly.

	Luben

