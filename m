Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270804AbTG0ORq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270806AbTG0ORq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:17:46 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:52375 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270804AbTG0ORo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:17:44 -0400
Message-ID: <3F23E2CA.7070107@softhome.net>
Date: Sun, 27 Jul 2003 16:33:46 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: Vanilla not for embedded?! Re: Kernel 2.6 size increase -
 get_current()?
References: <dcQ9.7aj.35@gated-at.bofh.it> <dcQ9.7aj.31@gated-at.bofh.it> <dhFS.3R3.11@gated-at.bofh.it> <dSm7.4TZ.5@gated-at.bofh.it> <dTrN.5Te.7@gated-at.bofh.it>
In-Reply-To: <dTrN.5Te.7@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
>>   Patches to remove mandatory (for 2.2/2.0) PCI/IDE support were pretty 
>>common too.
>>   Patch to shrink network hashes - norm of life.
>>   Patch to kill PCI names database.
>>   And this is only things I was using personally (and I remember about) 
>>in my short 4 years carrier.
> 
> Would you mind publishing the patches ?
> 

   As I already answered privately - I do have them right now.
   And those patches were not mine.
   Most of them was collected right on lkml or from digests on lwn.net.

   [ I was playing only with network code - and I was concerned with 
performance more, than with image size. And had no luck achiving 
something. ]

> 
>>   CONFIG_TINY - http://lwn.net/Articles/14186/ - got something like 
>>this merged? - so I'm the first guy in the download queue on ftp.kernel.org!
> 
> 
> See CONFIG_EMBEDDED.
> 

   Okay. I have found it.
   But I cannot find how it is used.
   I have grepped thru 2.6.0-test0 - but I can find only entries in 
defconfigs - but no mentions in .h/.c files.
   What I'm missing?

   And yes - this option doesn't work in 'make menuconfig'.

>>   For some reasons all "improvements" to kernel had lead to increase of 
>>kernel size, not decrease. Strange, isn't it?
> 
> No time for sarcasm here.
> 

   Correct me if I'm wrong.
   I was just poking around 'small is beatiful'.


P.S. To my earlier 'far from vanilla' comment (-x '.*' - to skip 
.depend/.config/etc):
$ diff -urN -x '.*' ./linux-2.4.17 \
/opt/hardhat/devkit/lsp/ibm-walnut-ppc_405/linux-2.4.17_mvl21\
| wc -l
     1128089
$
and more than 500 additional CONFIG_* parameters comparing to vanilla.

