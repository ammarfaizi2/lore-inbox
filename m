Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272328AbRIEVbf>; Wed, 5 Sep 2001 17:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272329AbRIEVbZ>; Wed, 5 Sep 2001 17:31:25 -0400
Received: from mail.mbi-berlin.de ([194.95.11.12]:16082 "EHLO
	mail.mbi-berlin.de") by vger.kernel.org with ESMTP
	id <S272328AbRIEVbN>; Wed, 5 Sep 2001 17:31:13 -0400
Message-ID: <3B969A08.A343546A@informatik.hu-berlin.de>
Date: Wed, 05 Sep 2001 23:32:56 +0200
From: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: OOPS and hard locks when trying to access an CD-RW drive via 
 ide-scsi
In-Reply-To: <3B9570F0.5E6DF01B@informatik.hu-berlin.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I should have paid more attention to this error message:

>         scsi : aborting command due to timeout pid 0, scsi 1, channel 0, id 0,
> lun 0 Read (10) 00 00 00 00 00 00 00 01 00
>         hda: timeout waiting for DMA
>         ide_dmaproc : chipset supported ide_dma_timeout func only: 14

I disabled dma with hdparm, now the RICOH works like a charm.

As for the oops ... if there's anything I can try out, let me now.

Viktor
-- 
Viktor Rosenfeld
WWW: http://www.informatik.hu-berlin.de/~rosenfel/
