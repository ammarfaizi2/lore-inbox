Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSEILey>; Thu, 9 May 2002 07:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315722AbSEILev>; Thu, 9 May 2002 07:34:51 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:5000 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S315720AbSEILei>;
	Thu, 9 May 2002 07:34:38 -0400
Date: Thu, 9 May 2002 13:34:55 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: mikeH <mikeH@notnowlewis.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: lost interrupt hell - Plea for Help
In-Reply-To: <3CD81676.90909@notnowlewis.co.uk>
Message-ID: <Pine.LNX.3.96.1020509132713.1987A-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 7 May 2002, mikeH wrote:

> Hi all,
> 
> *bang*
> 
> *bang*
> 
> Hear that? Its my head, against the wall. ;)
> 
> I am trying to convert my audio cds to mp3, which involves first ripping 
> the track as a wav.
> 
> I have two drives, one Creative DVD 5x, one LG CDRW drive.
> My chipet is VIA K7 266 pro, 1.2ghz duron.
> 
> I have tried every combination of master / slave between the two drives, 
> the drives on their own, scsi emulation through ide-scsi, purely as IDE 
> drives, ommitting ide cdrom support from teh kernel completely and only 
> using ide-scsi... every time I try to get a track ripped, dmesg fills up 
> with hdX: lost interrupt.
> 
> If I try to rip from the DVD drive, the system hangs and its reset 
> button time.
> 
> I am using 2.4.18.
> 
> Can anyone tell me where I'm going wrong? Is there anything from my 
> system you need to see to help me?

Hi again. I've thought I've already given up but just to be sure and not
forget about anything (yes, some people - like me - don't know when to
stop and go home):

1. Have you tried another ide cables?
2. Do they stick ok?
3. How about unplugging CD completely from the motherboard?
4. Perhaps you need to compile via-specific options into your kernel.

In my case, every time I've seen lost interrupt it was something from the
above.

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBPNpe5RETUsyL9vbiEQITcgCgkbVDKfJBOgysvqSueVhfkpFHPWYAoJcN
uVjucDNFdWbqhQ8XBse+TxNl
=9MG2
-----END PGP SIGNATURE-----

