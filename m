Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVGXTKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVGXTKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVGXTKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:10:43 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:25560 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261445AbVGXTKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:10:41 -0400
Message-ID: <42E3E7AC.2040209@ribosome.natur.cuni.cz>
Date: Sun, 24 Jul 2005 21:10:36 +0200
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Giving developers clue how many testers verified certain kernel
 version
References: <42E04D11.20005@ribosome.natur.cuni.cz> <20050722231126.GB3160@stusta.de> <42E3E1BC.2050509@ribosome.natur.cuni.cz> <20050724185419.GV3160@stusta.de>
In-Reply-To: <20050724185419.GV3160@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,
  I think you don't understand me. I do report bugs and will always
do. The point was that developers could be "assured" there is possibly
no problem when people do NOT report bugs in that piece of code
because they would know that it _was_ tested by 1000 people on 357 different
HW's. And they could even check the .configs, lshw etc. Sure the people
would report a problem, but if you do NOT hear of one then there is either no
problem or nobody cared to report that or nobody tested. So you known
just nothing and you better wait some days, weeks so the patch get's lost
in lkml archives if it doesn't happend it gets into -ac or -mm.

  And that is exactly why I proposed this. Then you will know that 1000
people really cared and used that and most probably then it is reasonable
to expect there is really no bug in the code.

  Take it the other way around. You may be reluctant to commit some
patch to the official tree. ;) The guy who wrote the patch says "It was tested,
please apply". ;-) If he says the patch is lying in -mm or -ac tree for
a while - like 2 months you might be more in favor to commit, right?
If you know the patch was tested between -git5 and -git6 by 1000 people
within 5 days you wouldn't wait either, right?
Martin

Adrian Bunk wrote:
> On Sun, Jul 24, 2005 at 08:45:16PM +0200, Martin MOKREJ? wrote:
>> well, the idea was to give you a clue how many people did NOT complain
>>because it either worked or they did not realize/care. The goal
>>was different. For example, I have 2 computers and both need current acpi
>>patch to work fine. I went to bugzilla and found nobody has filed such bugs
>>before - so I did and said it is already fixed in current acpi patch.
>>But you'd never know that I tested that successfully. And I don't believe
>>to get emails from lkml that I installed a patch and it did not break
>>anything. I hope you get the idea now. ;)
> 
> 
> in your ACPI example there is a bug/problem (ACPI needs updating).
> 
> And ACPI is a good example where even 1000 success reports wouldn't help 
> because a slightly different hardware or BIOS version might make the 
> difference.
> 
> Usually "no bug report" indicates that something is OK.
> And if you are unsure whether an unusual setup or hardware is actually 
> tested, it's usually the best to ask on linux-kernel whether someone 
> could test it.
