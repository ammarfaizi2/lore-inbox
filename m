Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbUJ1MCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbUJ1MCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUJ1MCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:02:14 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:13012 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262997AbUJ1L7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:59:32 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
Date: Thu, 28 Oct 2004 07:59:28 -0400
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
Message-Id: <200410280759.28282.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.153.91.102] at Thu, 28 Oct 2004 06:59:28 -0500
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

OGAWA;  I didn't notice I wasn't running gnome, but use kde.  I have 
been able to mount, read the empty card in it, and unmount it 3 times 
with no Oops with the unpatched 2.6.10-rc1-bk6 kernel.  Now I'll 
reboot and retest tour patch.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
