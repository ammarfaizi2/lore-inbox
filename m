Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945970AbWBDJeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945970AbWBDJeb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945986AbWBDJeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:34:31 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:39055 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1945970AbWBDJeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:34:31 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E4742F.7060609@s5r6.in-berlin.de>
Date: Sat, 04 Feb 2006 10:30:23 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       bcollins@debian.org, scjody@modernduck.com,
       linux-kernel@vger.kernel.org, sam@ravnborg.org,
       Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 2.6.16-rc1-mm5: drivers/ieee1394/oui O=... builds broken
References: <20060203000704.3964a39f.akpm@osdl.org> <20060203212507.GR4408@stusta.de> <43E46F1F.9070503@s5r6.in-berlin.de>
In-Reply-To: <43E46F1F.9070503@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.671) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2nd attempt with corrected list of recipients)

I wrote:
> Adrian Bunk wrote:
>> ...
>>   OUI2C   drivers/ieee1394/oui.c
>> /bin/sh: drivers/ieee1394/oui2c.sh: No such file or directory
>> make[3]: *** [drivers/ieee1394/oui.c] Error 127
>>
>> <--  snip  -->
>>
>>
>> The change that broke it is:
>>
>>
>>  quiet_cmd_oui2c = OUI2C   $@
>> -      cmd_oui2c = $(CONFIG_SHELL) $(srctree)/$(src)/oui2c.sh < $< > $@
>> +      cmd_oui2c = $(CONFIG_SHELL) $(src)/oui2c.sh < $< > $@
> 
> 
> How can this be reproduced? IOW which way of building the kernel is broken?


-- 
Stefan Richter
-=====-=-==- --=- --=--
http://arcgraph.de/sr/
