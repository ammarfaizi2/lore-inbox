Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbTBIS7P>; Sun, 9 Feb 2003 13:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTBIS7P>; Sun, 9 Feb 2003 13:59:15 -0500
Received: from tibau-e1.pop-rio.com.br ([200.239.194.250]:36003 "EHLO
	tibau.pop-rio.com.br") by vger.kernel.org with ESMTP
	id <S267430AbTBIS7N>; Sun, 9 Feb 2003 13:59:13 -0500
Date: Sun, 9 Feb 2003 17:06:24 -0200
From: Andre Costa <acosta@ar.microlink.com.br>
To: Linux kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.x + via-based kt266 mobo = IDE cdroms probls
 (revisited)
Message-Id: <20030209170624.2e6e981f.acosta@ar.microlink.com.br>
In-Reply-To: <20030207170001.3d8bc96a.acosta@ar.microlink.com.br>
References: <20030207170001.3d8bc96a.acosta@ar.microlink.com.br>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MailScanner: Microlink Internet Provider Anti-Virus, Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, replying to my own msg just to post some updates:

it has been confirmed by me and others that downgrading AMI BIOS on our
specific mobo (MSI KT266Pro2) to v3.3 fixes the "lost interrupt" errors
with cd audio ripping. Latest BIOS is 3.7:

[http://www.msi.com.tw/program/support/bios/bos/spt_bos_detail.php?UID=28&NAME=MS-6380]

Any suggestion on how we could pressure AMI or MSI to fix this probl on
BIOS versions higher than 3.3? (or, maybe, to provide you guys some docs
explaining the changes so that Linux kernel can catch up, considering
that the probl doesn't happen on Win2k/XP?)

Best,

Andre

On Fri, 7 Feb 2003 17:00:01 -0200
Andre Costa <acosta@ar.microlink.com.br> wrote:

> Hi all,
> 
> owners of VIA KT266-based mobos with IDE cdroms are unable to rip
> audio tracks using both SCSI emulation and native IDE mode (kernel
> 2.4.x). Symptoms are "lost interrupts" such as:
> 
> Jan 8 21:04:28 candy kernel: scsi : aborting command due to timeout :
> pid 13448, scsi0, channel 0, id 0, lun 0 UNKNOWN(0xbe) 00 00 00 00 00
> 00 00 07 f8 00 00 Jan 8 21:04:28 candy kernel: hdc: lost interrupt 
> Jan 8 21:05:28 candy kernel: scsi : aborting command due to timeout :
> pid 13458, scsi0, channel 0, id 0, lun 0 UNKNOWN(0xbe) 00 00 00 00 7c
> 00 00 0d f8 00 00 Jan 8 21:05:28 candy kernel: hdc: lost interrupt 
> Jan 8 21:06:30 candy kernel: scsi : aborting command due to timeout :
> pid 13493, scsi0, channel 0, id 0, lun 0 UNKNOWN(0xbe) 00 00 00 00 fc
> 00 00 0d f8 00 00 Jan 8 21:06:30 candy kernel: hdc: lost interrupt 
> 
> This probl has been briefly discussed here a while ago:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103382933709162&w=2
> 
> Since then, it has also been discussed more thoroughly on other places
> as well:
> 
> Linuxhardware.org
> http://www.linuxhardware.org/article.pl?sid=02/12/22/1732217
> 
> MSI forums
> http://www.msi.com.tw/program/e_service/forum/viewthread.php?threadid=7790&boardid=13
> 
> VIA Arena Linux Forum
> http://forums.viaarena.com/messageview.cfm?catid=28&threadid=28308&STARTPAGE=1
> 
> Some guy reported success after downgrading his BIOS to an earlier
> version (unfortunately we could not contact him again after this
> report). So, there is a chance that BIOS might be the culprit.
> 
> HOWEVER, *every* machine that shows this probl with Linux is perfectly
> capable of ripping audio tracks while running Win2k/XP, so there's got
> to be a solution.
> 
> So, my question is: are you guys aware of such probl? Any solution in
> the horizon? Any help we could offer (aside from coding)? Me and other
> guys experiencing this same probl have joined together, we even have
> an e-group dedicated to it. We're eager to help in finding a solution,
> but unfortunately we won't be able to help directly with code...
> 
> TIA
> 
> Andre
> 
> -- 
> Andre Oliveira da Costa
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Andre Oliveira da Costa
