Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUGYUce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUGYUce (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 16:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUGYUce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 16:32:34 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:28581 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S264396AbUGYUcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 16:32:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Sun, 25 Jul 2004 16:32:11 -0400
User-Agent: KMail/1.6
References: <200407242156.40726.gene.heskett@verizon.net> <200407250943.05592.gene.heskett@verizon.net> <0A8CE086-DE59-11D8-9612-000393ACC76E@mac.com>
In-Reply-To: <0A8CE086-DE59-11D8-9612-000393ACC76E@mac.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407251632.11843.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.57.16] at Sun, 25 Jul 2004 15:32:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 July 2004 12:38, Kyle Moffett wrote:
>On Jul 25, 2004, at 09:43, Gene Heskett wrote:
>> Humm, maybe I missunderstand you:
>> [root@coyote linux-2.6.8-rc2-nf2]# objdump -d
>> </boot/vmlinuz-2.6.8-rc2-nf2>.o >file.objdump
>> objdump: a.out: No such file or directory
>
>Heh.  You aren't supposed to put the angle-brackets around the file.
>The shell reads this like thie following:
># cat '/boot/vmlinux-2.6.8-rc2-nfs>.o' | objdump -d >file.objdump..
>Then objdump doesn't get an input file, so it looks for the default
>input file, "a.out", which it can't find.  Just write it like the
>following:
># objdump -d /boot/vmlinux-2.6.8-rc2-nf2 >file.objdump
>Or the following:
># objdump -d dcache.o >file.objdump

I'll do the latter, the result should be a heck of a lot smaller.  
But, after I've chased the lawn mower around for a couple of hours 
while a new psu gets the stink blown out of it and all over the 
house.  This yard place is beginning to look like a tarzan 
movie.  :-)

>
>Cheers,
>Kyle Moffett
>
>-----BEGIN GEEK CODE BLOCK-----
>Version: 3.12
>GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
>L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
>PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$
> r !y?(-)
>------END GEEK CODE BLOCK------

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
