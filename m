Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143909AbRA1TcG>; Sun, 28 Jan 2001 14:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143940AbRA1Tb4>; Sun, 28 Jan 2001 14:31:56 -0500
Received: from kashiwa8-84.ppp-1.dion.ne.jp ([210.157.148.84]:5650 "EHLO
	ask.ne.jp") by vger.kernel.org with ESMTP id <S143909AbRA1Tbk>;
	Sun, 28 Jan 2001 14:31:40 -0500
Date: Mon, 29 Jan 2001 04:31:43 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: "paradox3" <paradox3@maine.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
Message-Id: <20010129043143.3ac5fd99.bruce@ask.ne.jp>
In-Reply-To: <002901c08951$f751bfa0$b001a8c0@caesar>
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar> <20010128174016.3fba71ad.bruce@ask.ne.jp>
	<002901c08951$f751bfa0$b001a8c0@caesar>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.6; Linux 2.2.17; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hm. As a point of comparison, I use a similar system to yours (full SCSI,
though, no IDE) and I can copy a 100MB file from disk-to-disk, or on the
same disk, in around 13 seconds. Where are you copying to the SCSI drive
from - the same drive, an IDE disk, CDROM? If IDE, what are its
particulars? (Check with hdparm -iI /dev/hd?)

--
Bruce Harada
bruce@ask.ne.jp



On Sun, 28 Jan 2001 12:44:29 -0500
"paradox3" <paradox3@maine.rr.com> wrote:
>
> I don't get any messages relating to the drives in any syslog output.
> 
> >
> > Do you get messages like the ones below in /var/log/messages?
> >
> >   sym53c875-0-<0,0>: QUEUE FULL! 8 busy, 7 disconnected CCBs
> >   sym53c875-0-<0,0>: tagged command queue depth set to 7
> >
> > In fact, do you get any messages in your log files that look like they
> > might be related?
> >
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
