Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTKNT6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTKNT6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:58:49 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:33417 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261500AbTKNT6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:58:48 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Maciej Zenczykowski <maze@cela.pl>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 14:58:46 -0500
User-Agent: KMail/1.5.1
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Patrick Beard <patrick@scotcomms.co.uk>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311142013320.7550-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0311142013320.7550-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311141458.47052.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.12.17] at Fri, 14 Nov 2003 13:58:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 November 2003 14:13, Maciej Zenczykowski wrote:
>> What does this tell us?
>
>Have you tried running a dosfsck on that?
>
No, but here it is, on both sda and sda1:

[root@coyote root]# dosfsck /dev/sda
dosfsck 2.8, 28 Feb 2001, FAT32, LFN
Logical sector size is zero.

[root@coyote root]# dosfsck /dev/sda1
dosfsck 2.8, 28 Feb 2001, FAT32, LFN
/dev/sda1: 2 files, 2/3997 clusters

That first one doesn't look kosher to me!
Q: Is FAT32 the same as VFAT?

>Cheers,
>MaZe.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

