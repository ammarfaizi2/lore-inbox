Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136905AbRA1HtJ>; Sun, 28 Jan 2001 02:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136761AbRA1HtA>; Sun, 28 Jan 2001 02:49:00 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:46092
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136527AbRA1Hso>; Sun, 28 Jan 2001 02:48:44 -0500
Date: Sat, 27 Jan 2001 23:48:31 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: paradox3 <paradox3@maine.rr.com>
cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar>
Message-ID: <Pine.LNX.4.10.10101272344330.26668-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


WOOHOO, first report where I win one against the ever losing battle
against SCSI....paradox3, you made my evening...

Also please add to the sign on I95 exit 2...

""Welcome to Maine", 'now you can go home, now'"

Caution Moose will attempt to mate with cars carrying canoes in the winter.

Cheers,

Andre Hedrick
Linux ATA Development
 
On Sun, 28 Jan 2001, paradox3 wrote:

> I have an SMP machine (dual PII 400s) running 2.2.16 with one 10,000 RPM IBM
> 10 GB SCSI drive
> (AIC 7890 on motherboard, using aic7xxx.o), and four various IDE drives. The
> SCSI drive
> performs the worst. In tests of writing 100 MB and sync'ing, one of my IDE
> drives takes 31 seconds. The SCSI drive (while doing nothing else) took
> 2 minutes, 10 seconds. This is extremely noticable in file transfers that
> completely
> monopolize the SCSI drive, and are much slower than when involving the IDE
> drives.
> After a large data operation on the SCSI drive, the system will hang for
> several minutes.
> Anyone know what could be causing this? Thanks.
> 
> Attached are some data to help.
> 
> 
> Thanks,
>     Para-dox (paradox3@maine.rr.com)
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
