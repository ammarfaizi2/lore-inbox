Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUFOSYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUFOSYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUFOSWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:22:48 -0400
Received: from dsl254-100-188.nyc1.dsl.speakeasy.net ([216.254.100.188]:23941
	"EHLO chewbaka.solo.net") by vger.kernel.org with ESMTP
	id S265823AbUFOSVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:21:08 -0400
Date: Tue, 15 Jun 2004 14:21:13 -0400 (EDT)
From: Hans Solo <hans@hanssolo.org>
X-X-Sender: hans@chewbaka.solo.net
To: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 still utterly broken in 2.6.7-rc3
Message-ID: <Pine.LNX.4.44.0406151404160.3815-100000@chewbaka.solo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben Collins wrote:
> On Tue, Jun 15, 2004 at 05:53:54PM +0200, Felix von Leitner wrote:
>>
>> It's an Athlon mainboard with VIA chipset.
>
> Is firewire built-in to the kernel? I haven't seen any of these problems
> _at all_, but I use modules. I have a 250gig firewire disk that is used
> for nightly backups for 5 systems via rsync and ssh, and it never shows
> any problems.

I have a similar setup here; 250Gb on an Oxford922 doing nightly
backups via rsync. Athlon mainboard with VIA chipset. ieee1394,
ohci1394, sbp2 as modules. I get seemingly random crashes that
freeze the system solid, no oopses. Sometimes I get a few of these:

Jun 13 06:12:14 chewbaka kernel: ieee1394: sbp2: aborting sbp2 command
Jun 13 06:12:14 chewbaka kernel: Write (10) 00 00 89 4c 33 00 00 08 00 

but I can't decide if this is related.

If I unplugg the drive and then re-plugg it, the failure is
easiy reproduced with some heavy disk activity (copying a file-
system to the firewire disk for example).

Any idea about where to start looking? I have tried various
options for sbp2 in /etc/modprobe.conf. Let me know if you
want my .config etc.


Thanks,

Hans



-- 
()  ascii ribbon campaign - against html e-mail
/\                        - against microsoft attachments

