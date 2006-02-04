Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945993AbWBDKC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945993AbWBDKC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945994AbWBDKCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:02:25 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:19602 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1945993AbWBDKCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:02:25 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E47ABD.1040101@s5r6.in-berlin.de>
Date: Sat, 04 Feb 2006 10:58:21 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       bcollins@debian.org, scjody@modernduck.com,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       sam@ravnborg.org
Subject: Re: 2.6.16-rc1-mm5: drivers/ieee1394/oui O=... builds broken
References: <20060203000704.3964a39f.akpm@osdl.org>	 <20060203212507.GR4408@stusta.de>  <43E46F1F.9070503@s5r6.in-berlin.de> <1139045463.3602.1.camel@localhost>
In-Reply-To: <1139045463.3602.1.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.769) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> On Sat, 2006-02-04 at 10:08 +0100, Stefan Richter wrote:
>>Adrian Bunk wrote:
>>>...
>>>  OUI2C   drivers/ieee1394/oui.c
>>>/bin/sh: drivers/ieee1394/oui2c.sh: No such file or directory
>>>make[3]: *** [drivers/ieee1394/oui.c] Error 127
...
>>How can this be reproduced? IOW which way of building the kernel is broken?
...
> I was pretty sure I tested the normal in-kernel build way,

When I confirmed your patch, I had successfully tested it on pristine 
and on pre-built 2.6.15.1 and 2.6.16-rc1 trees when running make from 
the trees' root directory, using the default shell of MDK 10.1.

But Adrian is right, "make O=/some/place/else" is broken. Which answers 
my question above.
-- 
Stefan Richter
-=====-=-==- --=- --=--
http://arcgraph.de/sr/
