Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSHTVnz>; Tue, 20 Aug 2002 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSHTVnz>; Tue, 20 Aug 2002 17:43:55 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:3579 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317387AbSHTVnz>; Tue, 20 Aug 2002 17:43:55 -0400
Message-ID: <3D62B8D3.24021C67@bigpond.com>
Date: Wed, 21 Aug 2002 07:46:59 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4 blows away Xwindows with Matrox G400 and DRM
References: <3D621BF8.F1242760@bigpond.com> <1029847355.22983.3.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Also look in dmesg - you should see messages about the loading of the
> matrox drm module

I had a look in var/log/dmesg of a good boot, and that stops logging
when all the partitions are up.  The command "dmesg" goes a little
further and includes the agpgart and drm along with eth0 etc., but
I can't run _that_ on the failed pre4 'cause it reboots instantly.

The last line of /var/log/messages before "restart" for the failed
boot would normally be followed by messages on the start of agpgart
followed by drm.

There is a little in the ksymoops, "start modprobe agpgart safemode=0"
followed by the first line of the next boot.

I forgot to mention before, I'm running ext3, and the Matrox drivers
from 28 Feb 02 (current) on essentially a RedHat 7.3, but with gcc 3.2


Any other logging I could set up?
