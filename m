Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311694AbSCNRlU>; Thu, 14 Mar 2002 12:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311695AbSCNRlL>; Thu, 14 Mar 2002 12:41:11 -0500
Received: from smokey.blackcatnetworks.co.uk ([212.135.138.139]:50375 "EHLO
	smokey.blackcatnetworks.co.uk") by vger.kernel.org with ESMTP
	id <S311694AbSCNRlB>; Thu, 14 Mar 2002 12:41:01 -0500
Date: Thu, 14 Mar 2002 17:40:27 +0000
From: Alex Walker <alex@x3ja.co.uk>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.6 and 2.5.7-pre1 - reiserfs?
Message-ID: <20020314174027.H9664@x3ja.co.uk>
In-Reply-To: <20020314162009.F9664@x3ja.co.uk> <20020314192916.A1929@namesys.com> <20020314170123.G9664@x3ja.co.uk> <20020314200337.A2186@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314200337.A2186@namesys.com>; from green@namesys.com on Thu, Mar 14, 2002 at 08:03:37PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 08:03:37PM +0300, Oleg Drokin wrote:
> > Whilst I'm here... Is there a neat way to convert your root system
> > from 3.5 to 3.6?  I tried "mount -o remount,conv /" which gave no
> > errors, but didn't actually convert it.  I also tried adding conv to
> > the options in /etc/fstab, but to similar effect...  Do I have to
> > copy to a different partition with a 3.6 format and use that as my
> > root to do it?
> I think you need to pass "rootflags=conv" option to your kernel.  That
> should work. Esp. if you do not use any kind of initrd.

This doesn't work, sorry.

I get:
EXT3-fs: Unrecognized mount option conv
EXT2-fs: Unrecognized mount option conv
found reiserfs format "3.5" with standard journal
[Usual boot messages]

on boot, which is odd.  I do have some EXT3 partitions too, but my root
is certainly reiserfs.

This probably isn't the right place to be asking for this kind of help I
guess, but if anyone can shed any light - I would appreciate it.

However I am in the process of creating some reiserfs boot disks so I
can convert it...

Alex

-- 
      ALEX|X3JA
   alex@x3ja.co.uk
    ICQ: 1523424
MSN: x3ja@hotmail.com
