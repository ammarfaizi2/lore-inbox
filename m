Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbUDWUDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUDWUDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUDWUDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:03:00 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:52405 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261221AbUDWUC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:02:57 -0400
Date: Fri, 23 Apr 2004 21:50:04 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Unable to read UDF fs on a DVD
Message-ID: <20040423195004.GA1885@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040423162801.GA5396@dreamland.darkstar.lan> <1082743002.3099.23.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082743002.3099.23.camel@patibmrh9>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, Apr 23, 2004 at 11:56:42AM -0600, Pat LaVarre ha scritto: 
> > ....# ls /cdrom
> > /bin/ls: /cdrom/Bakuretsu Tenshi - 01.avi: No such file or directory
> > /bin/ls: /cdrom/Bakuretsu Tenshi - 02.avi: No such file or directory
> > [etc]
> > 
> > I can mount the disk and read it using ISO9660 instead of UDF (filenames
> > are 8+3, no Joliet it seems), and I can read it under WinXP. It
> > shouldn't be damaged.
> 
> Q1) Any Linux dmesg as you try to read or umount?

No, nothing at all.


> Q2) What text does the DIR /S command of Windows produce?

 Il volume nell'unita` D e` CDROM
 Numero di serie del volume: A381-DC88

 Directory di D:\

10/04/2004  20.59       240.695.296 Bakuretsu Tenshi - 01.avi
16/04/2004  15.13       240.715.776 Bakuretsu Tenshi - 02.avi
13/04/2004  18.57       182.452.224 Full Metal Alchemist - 11.avi
13/04/2004  18.57       182.452.224 Full Metal Alchemist - 12.avi
13/04/2004  18.57       182.452.224 Full Metal Alchemist - 13.avi
13/04/2004  18.57       178.257.920 Full Metal Alchemist - 14.avi
13/04/2004  18.57       178.257.920 Full Metal Alchemist - 15.avi
14/04/2004  15.55       178.257.920 Full Metal Alchemist - 16.avi
14/04/2004  15.55       178.257.920 Full Metal Alchemist - 17.avi
14/04/2004  15.55       178.257.920 Full Metal Alchemist - 18.avi
14/04/2004  15.35       178.257.920 Full Metal Alchemist - 19.avi
14/04/2004  15.35       178.257.920 Full Metal Alchemist - 20.avi
17/04/2004  15.15       178.257.920 Full Metal Alchemist - 21.avi
17/04/2004  17.32       178.257.920 Full Metal Alchemist - 22.avi
17/04/2004  20.41       178.257.920 Full Metal Alchemist - 23.avi
18/04/2004  01.26       178.257.920 Full Metal Alchemist - 24.avi
18/04/2004  11.07       178.257.920 Full Metal Alchemist - 25.avi
18/04/2004  16.48       178.257.920 Full Metal Alchemist - 26.avi
13/04/2004  10.26       178.257.920 Full Metal Alchemist - 27.avi
19/04/2004  11.30       184.088.576 Full Metal Alchemist - 28.avi
14/02/2004  12.41       224.397.312 Ghost in the Shell - Stand Alone Complex - 00.avi
14/02/2004  12.13       147.292.160 Ghost in the Shell - Stand Alone Complex - 01.avi
14/02/2004  21.28       187.267.072 Ghost in the Shell - Stand Alone Complex - 02.avi
13/04/2004  04.12       182.564.864 Planetes - phase 13.avi
              24 File  4.449.988.608 byte

     Totale file elencati:
              24 File  4.449.988.608 byte
               0 Directory               0 byte disponibili

> > created under Windows, using Easy CD Creator
> > (don't know the details).
> 
> Q3) What does Linux fsck tell you, before you mount -o ro (or after you
> umount)?

I used udfct utility (from Philips). The output is quite long, I put it
here:

http://web.tiscali.it/kronoz/ucf_test.log

I don't see anything strange.

Btw, don't know if it's related but I was unable to run ucf_test without
scsi emulation: it complained about unknown image chunk size. I can't
read files even with ide-scsi, though.

> P.S. The subscriber-only archives of linux_udf@h... currently show
> Linux-2.6.5 issues now under discussion, including an issue people have
> reproduced by downloading a huge trial .exe into Windows and then
> copying a file of more than 2 GiB to the disc.

I think that this is a different issue, files on my disk are smaller.

thanks,
Luca
-- 
Home: http://kronoz.cjb.net
Porc i' mond che cio' sott i piedi!
V. Catozzo
