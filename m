Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262985AbUJ1MQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbUJ1MQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbUJ1MQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:16:23 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:29406 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262985AbUJ1MMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 08:12:47 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
Date: Thu, 28 Oct 2004 08:12:41 -0400
User-Agent: KMail/1.7
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Nigel Kukard <nkukard@lbsd.net>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <41809921.10200@lbsd.net> <873bzzw60c.fsf@devron.myhome.or.jp> <200410280714.40033.gene.heskett@verizon.net>
In-Reply-To: <200410280714.40033.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410280812.41150.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [141.153.91.102] at Thu, 28 Oct 2004 07:12:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 07:14, Gene Heskett wrote:
>On Thursday 28 October 2004 05:23, OGAWA Hirofumi wrote:
>>Nigel Kukard <nkukard@lbsd.net> writes:
>>> OOPS is 100% reproducable. I boot into X, and run    eog
>>> /mnt/camera/dcim/100cresi    and BANG.
>>
>>This is known problem. Can you please try the following patch?
>>Then, please send debugging output.
>>
>>Thanks.
>
>This still applies cleanly to 2.6.10-rc1-bk6, so I'm building it to
>test also.  I have an Olympus C-3020 that mounts as a vfat file
>system over usb.  It has been somewhat of a problem if the card has
>quite a few pix on it, I must copy, and delete, from the bottom of
>the dirlisting else it goes read-only on me.  When the build is
> done, I'll try mounting it to see if this also gives an Oops, then
> reboot and try again, and report the results.

After the reboot to a 2.6.10-rc1-bk6 plus your patch, its still fine, 
and except for the usual references to /dev/sda1 in the log when I 
turn it on or off, mounting it and scanning its directory doesn't 
generate any additional log info.  Was it supposed to?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
