Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUBPRCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUBPRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:01:59 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:60420 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265669AbUBPRB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:01:57 -0500
Message-ID: <4030F94F.1000900@techsource.com>
Date: Mon, 16 Feb 2004 12:09:35 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Balaji Calidas <balaji@techsource.com>
Subject: 2.4.24 problems [WAS: Re: IDE DMA problem  [WAS: Re: Getting lousy
 NFS + tar-pipe throughput on 2.4.20]]
References: <402D6262.90301@techsource.com> <402D68CB.2030803@techsource.com> <200402140154.54307.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402140154.54307.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bartlomiej Zolnierkiewicz wrote:
> On Saturday 14 of February 2004 01:16, Timothy Miller wrote:
> 
>   Does 2.4.20 not work well with the KT600
>>chipset?
> 
> 
> It doesn't, upgrade to 2.4.24.


Ok, so we tried that.  That caused all sorts of havoc, most of which we 
might be able to figure out.  It seems that RedHat's utilities and stuff 
don't get along well with 2.4.24 if all you do is just boot the new 
kernel.  Seems a bunch of other stuff needs to be upgraded.

Also, 'root=LABEL=/' doesn't work anymore in grub.conf, and there seems 
to be no way to enable it.  Is this a RedHat only thing?

In any event, when we managed to get it to boot, it absolutely did NOT 
fix the DMA problem with the KT600.  Trying to enable it with hdparm 
still says "Operation not permitted".  We spend a LOT of time trying to 
make sure we got the kernel configured right with all of the right 
options, etc., but we're still without IDE DMA.

Any further suggestions?

Thanks.

