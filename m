Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157550AbQGaOAG>; Mon, 31 Jul 2000 10:00:06 -0400
Received: by vger.rutgers.edu id <S157443AbQGaN7r>; Mon, 31 Jul 2000 09:59:47 -0400
Received: from pec-58-36.tnt4.b2.uunet.de ([149.225.58.36]:2434 "EHLO router.abc") by vger.rutgers.edu with ESMTP id <S157557AbQGaN65>; Mon, 31 Jul 2000 09:58:57 -0400
Message-ID: <39858A9F.C272E4E8@baldauf.org>
Date: Mon, 31 Jul 2000 16:18:07 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.74 [en] (Win98; U)
X-Accept-Language: en,de-DE
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
Cc: Russell King <rmk@arm.linux.org.uk>, reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
References: <Pine.LNX.4.10.10007310700001.6252-100000@master.linux-ide.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu



Andre Hedrick wrote:

> On Mon, 31 Jul 2000, Xuan Baldauf wrote:
>
> > Now I made all my partitions noatime, and wow,
> >
> > sync; hdparm -C -Y /dev/hda; sync; hdparm -C /dev/hda
> >
> > does not necessarily spin up the disk!
>
> Because you have to issue a drive reset.

This is my intent, not to spin up the disk. (In my previous case, sync
always spun up the disk because the filesystem was not mounted with
"noatime".)

>
>
> Andre Hedrick
> The Linux ATA/IDE guy

Xuân.:o)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
