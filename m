Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281193AbRKEPrX>; Mon, 5 Nov 2001 10:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281194AbRKEPrO>; Mon, 5 Nov 2001 10:47:14 -0500
Received: from [212.113.174.249] ([212.113.174.249]:43554 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S281193AbRKEPrF>;
	Mon, 5 Nov 2001 10:47:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Ferreira <stormlabs@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cdrecord, ide-scsi and all 2.4.x kernels
Date: Mon, 5 Nov 2001 15:46:29 +0000
X-Mailer: KMail [version 1.3.1]
Cc: Andre Hedrick <andre@aslab.com>, Jens Axboe <axboe@suse.de>,
        Gadi Oxman <gadio@netvision.net.il>
In-Reply-To: <EXCH01SMTP012FVbS9s0001fe99@smtp.netcabo.pt>
In-Reply-To: <EXCH01SMTP012FVbS9s0001fe99@smtp.netcabo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP016BSqEMD00000a12@smtp.netcabo.pt>
X-OriginalArrivalTime: 05 Nov 2001 15:43:14.0776 (UTC) FILETIME=[94F63D80:01C16610]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for replying to my own message, but i just tested 2.2.18 & 2.2.19 with 
Hedrick's ide patches and they work flawlessly. I now tested for data 
corruption and on 2 subsequent reads of a CD, it produces slightly different 
data or simply aborts the read. I now tested both with ide-cd and ide-scsi. 
Both fail. ide-cd fails on read and ide-scsi on read & write. I plan to test 
with another CDRW drive just to be sure the drive isn't the problem.

On Saturday 03 November 2001 03:31, Ricardo Ferreira wrote:
>
> I tested kernels 2.4.1 , 2.4.8 & 2.4.12, 2.4.13, 2.4.13-ac5 & ac6 and all
> have this problem. I then tested 2.2.18 (when i still had openlinux
> installed. i since installed RH 7.2) with the ide patches and it runs
> cleanly. Not a single message from the kernel under the same load and using
> the same cdrecord binary (1.10) and the same (or equivalent) drivers
> loaded. So it isn't a hardware problem either.
