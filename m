Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAWRla>; Tue, 23 Jan 2001 12:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbRAWRlU>; Tue, 23 Jan 2001 12:41:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:33029 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129523AbRAWRlD>; Tue, 23 Jan 2001 12:41:03 -0500
Date: Tue, 23 Jan 2001 12:42:22 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Trever L. Adams" <trever_Adams@bigfoot.com>
cc: Patrizio Bruno <patrizio@dada.it>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <3A6D9BE6.8070400@bigfoot.com>
Message-ID: <Pine.LNX.4.32.0101231239440.7610-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Trever L. Adams wrote:

>> I think that your linux's partition has not been overwritten, but only the MBR
>> of your disk, so you probably just need to reinstall lilo. Insert your
>> installation bootdisk into your pc, then skip all the setup stuff, but the
>> choose of the partition where you want to install and the source from where
>> you want to install, then select just the lilo configuration (bootconfiguration
>> I mean), complete that step and reboot your machine, lilo will'be there again.
>>
>> P.
>>
>> On Tue, 23 Jan 2001, Trever L. Adams wrote:
>
>I hate to tell you this, but you couldn't be more wrong.  My MBR was
>fine.  Lilo was fine and ran fine.  The kernel even booted. The problem
>was my ext2 partition was scrambled but good (over 4 hours trying to fix
>it and answer all the questions that fsck threw out).  The ext2 drive
>lost a lot of data and suddenly had windows stuff all over it (yes, just
>like Mike, I had ttf fonts and other such things).

Lets get a few points clear..  Are we talking - you already had
both linux and WinXX installed, and rebooted from Linux into the
existing Windows setup, and next time you booted Windows Linux
was fried?

Sounds like you might have a partitioning problem where Windows
sees the disk geometry one way, and perhaps Linux sees it
differently.

I can't see at all how Windows could end up putting data on ext2
volumes though without read-write ext2 support in Windows.  Are
you running the freely available ext2 fs driver in Windows?




----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
One of the main causes of the fall of the Roman Empire was that,
lacking zero, they had no way to indicate successful termination
of their C programs.
  -- Robert Firth

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
