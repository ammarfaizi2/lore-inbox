Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUFQW7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUFQW7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 18:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUFQW7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 18:59:00 -0400
Received: from web41104.mail.yahoo.com ([66.218.93.20]:6149 "HELO
	web41104.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264058AbUFQW66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 18:58:58 -0400
Message-ID: <20040617225857.41605.qmail@web41104.mail.yahoo.com>
Date: Thu, 17 Jun 2004 15:58:57 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: space left on ext3 (2.6.6-bk3)
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0406180018530.9599@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> On a ext3 fs:
> 
> fast:/mnt/tmp# df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda3               958488    521864    387936  58% /mnt
> 
> fast:/mnt/tmp# cat /dev/zero > zr
> cat: write error: No space left on device
> 
> fast:/mnt/tmp# ls -l
> total 436624
> -rw-r--r--    1 root     root     446660608 Jun 18 00:23 zr
> 
> fast:/mnt/tmp# rm zr
> 
> fast:/mnt/tmp# df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda3               958488    521864    387936  58% /mnt
> 
> Is this an expected behaviour?.. Yeah, it is nice to have more space
> than 
> you think you have, but...

Have you tried running fsck on it?  How many inodes are available.

Tom


		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 
