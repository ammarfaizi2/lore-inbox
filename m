Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318234AbSHDVVL>; Sun, 4 Aug 2002 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSHDVVL>; Sun, 4 Aug 2002 17:21:11 -0400
Received: from web14006.mail.yahoo.com ([216.136.175.122]:61452 "HELO
	web14006.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318234AbSHDVVK>; Sun, 4 Aug 2002 17:21:10 -0400
Message-ID: <20020804212444.62360.qmail@web14006.mail.yahoo.com>
Date: Sun, 4 Aug 2002 14:24:44 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: Re: Linux 2.4.19-ac2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried 2.4.19-ac2.

On booting, when it hits the IDE stuff, I got:

hdc : Lost Interrupt
hdc : Lost Interrupt
hdc : Lost Interrupt
hdc : ATAPI 48X DVD-ROM ....

Then it gets a bit further:

scsi : Aborting command due to timeout : pid 30, scsi2, id 0 lun
0
inquiry 00 00 00 ff 00
(This looks to be my cd burner on hda - ide-scsi)

Then it loops on this continuously. I had to write out the above
by hand,
because it never gets to the point where it mounts my scsi drive
rw.

2.4.19-ac1 seems to work fine. (As well as all the ac series
from the past
4 weeks)

To avoid wrapping I stuck my lspci output and .config at the
following urls:

My .config file is here:
http://ac.marywood.edu/tspin/www/dotconfig.txt

My lspci -vvv is here:
http://ac.marywood.edu/tspin/www/lspci.txt

I am running a stock RedHat 7.3 system. 
gcc version 2.96 20000731
modutils 2.4.19
make 3.79.1
binutils  2.11.93.0.2
util-linux 2.11n

If I have done something stupid, let me know.

Thanks!

Tony




__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com
