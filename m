Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbQLARON>; Fri, 1 Dec 2000 12:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLAROD>; Fri, 1 Dec 2000 12:14:03 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:17300 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S129257AbQLARNv>; Fri, 1 Dec 2000 12:13:51 -0500
Date: Fri, 1 Dec 2000 16:41:38 +0000 (GMT)
From: Guennadi Liakhovetski <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
cc: Mike Dresser <mdresser@windsormachine.com>
Subject: PCI support in kernel
Message-ID: <Pine.GSO.4.21.0012011622040.12071-100000@acms23>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, this is a continuation of the 
"Re: DMA !NOT ONLY! for triton again..."
thread.

Mike Dresser wrote:
> I'm taking the case off the machine right now, i can guarantee you its
> not UDMA compatible, simply because this thing was made in early1997. :)
> 
> Here we go:
> 
> MDL WDAC21600-00H
> P/N 99-004199-000
> CCC F3 20 FEB 97

YEP! Mine is F6. Which means, that both of them are 'other than UDMA'. And
since yours supports DMA I'll assume that so does mine too. Which means
that the reason why I can't turn it on is BIOS - from your previous
postings. Please, can anybody here explain, how is this possible, if
ide.txt clearly says the contrary:
"(linux) does not use the BIOS for disk access"
or am I wrong somewhere? Shall I tell the kernel 
'hda=noprobe,... ide0=dma...'
?

> DCM: BHBBKLP
> 
> I've got various of these hard drives in service, for the last 4
> years.  Many run in windows pc's, and DMA mode in osr2 and newer, works,
> and is noticeablely faster.

Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
