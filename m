Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBVCdO>; Wed, 21 Feb 2001 21:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129693AbRBVCdE>; Wed, 21 Feb 2001 21:33:04 -0500
Received: from [216.184.166.130] ([216.184.166.130]:8008 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S130954AbRBVCcy>; Wed, 21 Feb 2001 21:32:54 -0500
Date: Wed, 21 Feb 2001 18:31:18 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.2
In-Reply-To: <Pine.LNX.4.10.10102211811430.1005-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.1010221182554.14140C-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Linus Torvalds wrote:

> Date: Wed, 21 Feb 2001 18:19:43 -0800 (PST)
> From: Linus Torvalds <torvalds@transmeta.com>
> To: Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Linux-2.4.2
> 
> 
> Ok, the patch looks huge (it's a meg and a half compressed, 6+ megs
> uncompressed), but most of the patch by far is S/390 updates and the new
> Cris architecture. 
> 
> The biggest real changes that impact normal users are the two bugs that
> could corrupt your harddisk. The IDE driver bug that Russell found has, to
> my knowledge, never been shown to happen on anything but his ARM machine,
> but for all we know it could be quite bad even on x86. Similarly, the
> elevator bug could cause corruption, but probably has not actually bit
> people in practice. But both are definitely deadly at least in theory even
> on bog-standard common PC hardware.
> 
> The reiserfs fix should hopefully make the "null bytes in log-files"
> problem a non-issue, and along with the smbfs/HIGHMEM thing it is
> certainly important for those that it can affect.
> 
> 		Linus
> 
> ----
> 
> final:
>  - sync up more with Alan
>  - Urban Widmark: smbfs and HIGHMEM fix
>  - Chris Mason: reiserfs tail unpacking fix ("null bytes in reiserfs files")
>  - Adan Richter: new cpia usb ID
>  - Hugh Dickins: misc small sysv ipc fixes
>  - Andries Brouwer: remove overly restrictive sector size check for
>    SCSI cd-roms

snip


Hi, 

Which -ac series patch does this match up with or superceed
ie should this be considered superior to -ac19 ?

Thnx much


-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
kerndev@sc-software.com
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

