Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTJTIWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTJTIWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:22:18 -0400
Received: from dyn-ctb-210-9-246-89.webone.com.au ([210.9.246.89]:48135 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262153AbTJTIWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:22:17 -0400
Message-ID: <3F939B1E.5020807@cyberone.com.au>
Date: Mon, 20 Oct 2003 18:21:50 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Svetoslav Slavtchev <svetljo@gmx.de>
CC: Jens Axboe <axboe@suse.de>, B.Zolnierkiewicz@elka.pw.edu.pl,
       andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: HighPoint 374
References: <20031020064831.GT1128@suse.de> <6286.1066637456@www51.gmx.net>
In-Reply-To: <6286.1066637456@www51.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Svetoslav Slavtchev wrote:

>>On Sun, Oct 19 2003, Bartlomiej Zolnierkiewicz wrote:
>>
>>>Andre, thanks for helpful hint.
>>>Svetoslav, the right person to whine about TCQ stuff is Jens Axboe 8-).
>>>
>>Well that's correct, but this looks more like an AS iosched bug :)
>>
>>>>You do not enable TCQ on highpoint without using the hosted polling
>>>>
>>timer.
>>
>>>>Oh and I have not added it, and so hit Bartlomiej up for the
>>>>
>>additions.
>>
>>For what? TCQ tests fine on a HPT370 here.
>>
>
>cmdline : acpi=off pci=noacpi elevator=deadline
>

Thanks, that would be good if you would test IDE TCQ problems with
elevator=deadline. If it is working fine there, but you still get
problems when using the default (AS) elevator then report them to me
please.


