Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293149AbSBWQA5>; Sat, 23 Feb 2002 11:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293150AbSBWQAq>; Sat, 23 Feb 2002 11:00:46 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:36245 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S293149AbSBWQAi>; Sat, 23 Feb 2002 11:00:38 -0500
Date: Sat, 23 Feb 2002 10:59:37 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: floppy in 2.4.17
In-Reply-To: <20020223160544.A1905@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0202231054460.11337-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello J.A. , Nice name .  I have verified that the floppy drive
	under 2.4.18-pre3 is in the same shape . Hth ,  JimL

# fdformat /dev/fd0u1440		,  Hmmm ,  Move little tab .
/dev/fd0u1440: Read-only file system
# fdformat /dev/fd0u1440		,  Hmmm ......
/dev/fd0u1440: Read-only file system
# tar -ztvf /dev/fd0			,  Hmmm ,  J.A.'s right .
(hang ..wait several minutes..)^C
tar (grandchild): Read error on /dev/fd0: Input/output error
tar (grandchild): At beginning of tape, quitting now
tar (grandchild): Error is not recoverable: exiting now

gzip: stdin: unexpected end of file
tar: Child returned status 1
tar: Error exit delayed from previous errors


On Sat, 23 Feb 2002, J.A. Magallon wrote:

> Hi.
>
> I am getting problems with floppy drive in 2.4.17.
> All started with floppy not working in 18-rc4, went back to 17
> and still does not work. Just plain 2.4.17, no patching.
>
> mkfs -t ext2 /dev/fd0 just hangs forever.
>
> mkfs -v -t ext2 /dev/fd0 gives:
>
> mke2fs 1.26 (3-Feb-2002)
> mkfs.ext2: bad blocks count - /dev/fd0
>
> Hardware:
>
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> ide-floppy driver 0.97.sv
>
> ???
>
> TIA
>
> --
> J.A. Magallon                           #  Let the source be with you...
> mailto:jamagallon@able.es
> Mandrake Linux release 8.2 (Cooker) for i586
> Linux werewolf 2.4.17 #2 SMP Sat Feb 23 15:08:17 CET 2002 i686

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

