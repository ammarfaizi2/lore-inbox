Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbREVN1T>; Tue, 22 May 2001 09:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbREVN1J>; Tue, 22 May 2001 09:27:09 -0400
Received: from femail24.sdc1.sfba.home.com ([24.0.95.149]:56783 "EHLO
	femail24.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S261683AbREVN06>; Tue, 22 May 2001 09:26:58 -0400
Date: Tue, 22 May 2001 09:26:48 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Adam <adam@cfar.umd.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: debugging xterm. 
In-Reply-To: <Pine.GSO.4.33.0105211827350.18075-100000@chia.umiacs.umd.edu>
Message-ID: <Pine.LNX.4.33.0105220926100.1590-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Adam wrote:

>I'm trying to debug xterm and it seems like it is just not my day (I
>suppose the "Abandon All Hope, Ye Who Enter Here" in the README for xterm
>is for a reason there after all :P )
>
>I running gdb on xterm. I'm running it as root, the current execution is
>at main.c:main() and gdb seems to get lost when calling getuid), any idea?
>Is there something special about getuid() I'm missing?
>
>(gdb) next
>1612                uid_t ruid = getuid();
>2: screen->respond = 1448543468
>1: screen = (TScreen *) 0x4000ae60
>(gdb) next
>1613                gid_t rgid = getgid();
>2: screen->respond = Cannot access memory at address 0x4
>Disabling display 2 to avoid infinite recursion.
>(gdb)
>
>it does not know where screen data structure is anymore..

This has nothing to do with the Linux kernel whatsoever.  Please
send your request to xpert@xfree86.org for help.


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Open Source advocate
       Opinions and viewpoints expressed are solely my own.
----------------------------------------------------------------------

