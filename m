Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136936AbRA1Ik6>; Sun, 28 Jan 2001 03:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136937AbRA1Ikt>; Sun, 28 Jan 2001 03:40:49 -0500
Received: from kashiwa8-10.ppp-1.dion.ne.jp ([210.157.148.10]:36881 "EHLO
	ask.ne.jp") by vger.kernel.org with ESMTP id <S136936AbRA1Iki>;
	Sun, 28 Jan 2001 03:40:38 -0500
Date: Sun, 28 Jan 2001 17:40:16 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: "paradox3" <paradox3@maine.rr.com>
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
Message-Id: <20010128174016.3fba71ad.bruce@ask.ne.jp>
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar>
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.6; Linux 2.2.17; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

Do you get messages like the ones below in /var/log/messages?

  sym53c875-0-<0,0>: QUEUE FULL! 8 busy, 7 disconnected CCBs
  sym53c875-0-<0,0>: tagged command queue depth set to 7

In fact, do you get any messages in your log files that look like they
might be related?

--
Bruce Harada
bruce@ask.ne.jp


On Sun, 28 Jan 2001 02:26:32 -0500
"paradox3" <paradox3@maine.rr.com> wrote:

> I have an SMP machine (dual PII 400s) running 2.2.16 with one 10,000 RPM
> IBM
> 10 GB SCSI drive
> (AIC 7890 on motherboard, using aic7xxx.o), and four various IDE drives.
> The
> SCSI drive
> performs the worst. In tests of writing 100 MB and sync'ing, one of my
> IDE
> drives takes 31 seconds. The SCSI drive (while doing nothing else) took
> 2 minutes, 10 seconds. This is extremely noticable in file transfers
> that
> completely
> monopolize the SCSI drive, and are much slower than when involving the
> IDE
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
