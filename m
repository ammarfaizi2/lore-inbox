Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130355AbQK0Qjr>; Mon, 27 Nov 2000 11:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130897AbQK0Qjh>; Mon, 27 Nov 2000 11:39:37 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:63018 "EHLO mel.alcatel.fr")
        by vger.kernel.org with ESMTP id <S130355AbQK0Qja>;
        Mon, 27 Nov 2000 11:39:30 -0500
Message-ID: <3A228705.85D818A3@vz.cit.alcatel.fr>
Date: Mon, 27 Nov 2000 17:08:38 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
Organization: xgen@linuxstart.com
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: Niels Happel <nhappel@planet-interkom.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible ISOFS Bug in 2.4.0-test11-pre7
In-Reply-To: <00112716562000.01054@ws-20>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niels Happel a écrit :

> Hello everybody,
>
> first of all: I am new to the linux-kernel list, so I don't know wheather
> writing here is allowed for everybody or developers only.
>
> Anyway, here it is:
>
> Hardware (SCSI-only system):
>
> Tekram 390 U2W (SYM53C8XX support compiled into the kernel)
> IBM U2W SCSI disks
> HP DAT SCSI Streamer
> Pioneer SCSI DVD
> Yamaha SCSI CD R/W
>
> Using kernel 2.4.0-test10 and earlier everything works fine.
> Using 2.4.0-test11 with the same kernel configuration an error message
> occured while accessing one of the mounted SCSI CD-ROMs:
> "kernel: _isofs_bmap: block < 0"
> Mounting them works fine, accessing them gives that error message.
> It can't be an SCSI CD-ROM hardware failure, because the error message
> occured at both drives (Pioneer and Yamaha) and it doesn't matter which
> CD-ROM I am using.
>

Same problem with ide-cs + ide-cd modules (IDE - PCMCIA)
kernel: _isofs_bmap: block < 0"


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
