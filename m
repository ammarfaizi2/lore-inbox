Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSGAQCs>; Mon, 1 Jul 2002 12:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSGAQCr>; Mon, 1 Jul 2002 12:02:47 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:51758 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S315708AbSGAQCp>; Mon, 1 Jul 2002 12:02:45 -0400
Message-ID: <3D207DB1.80902@fabbione.net>
Date: Mon, 01 Jul 2002 18:05:05 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
References: <200207011604.58253.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

>hi
>
>still - sorry if this is OT - I'm just too close to tear my hair or head off 
>or something
>
>The documentation everywhere, including the lilo 22.3.1 sample conf ffile 
>tells me "use boot = /dev/md0", but lilo, when run, just tells me 
>
>Fatal: Filesystem would be destroyed by LILO boot sector: /dev/md0
>
>Please help
>
>roy
>
>  
>
Hi Roy,
            I have some machines running root on raid but I always have
boot=/dev/hda and a second copy of lilo.con with boot pointing to /dev/hdb
or whatever drive it was.
What is really importat for you anyway is to be able to boot again if one of
the disk is failing. The raid will ensure you to keep the root but I 
always keep
a boot floppy for emergencies. Not all the BIOS supports a boot from 
/dev/hdb
(I used hda/b just as an example...).
At end if you loose a disk you will be always able to change it and boot 
again
to rebuilt it.

Fabio

