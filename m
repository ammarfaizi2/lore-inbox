Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRHINUN>; Thu, 9 Aug 2001 09:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269797AbRHINUE>; Thu, 9 Aug 2001 09:20:04 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:63875 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S269796AbRHINTp>; Thu, 9 Aug 2001 09:19:45 -0400
Date: Thu, 9 Aug 2001 23:20:23 +1000
From: john slee <indigoid@higherplane.net>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac10 (subjective comments)
Message-ID: <20010809232023.B3197@higherplane.net>
In-Reply-To: <20010808195133.A22469@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010808195133.A22469@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

before 2.4.7-ac6 i could start loading my linux-kernel mailbox (~22000
messages) in mutt and still have new eterms start up fairly quick.
haven't tried -ac10 yet but you didnt mention any vm changes... in fact
i can't see any in that time at all.  might be just subjective of
course, but ....  seems interactivity has gone downhill a bit.

the only change i've made recently is switching from ext2 to ext3 when i
booted -ac9.  could that be the culprit? vmstat shows about the same old
5MB/sec throughput while opening the mailbox as it did on ext2 (and on
previous kernels), so i'm guessing it isn't...

i just opened up a second instance of mutt and loaded the mailbox in it
too.  vmstat says it barely touched the disk at all, and eterms came up
instantly.

-rw-------    1 indigoid indigoid 84718132 Aug  9 22:40 linux-kernel

hardware:
	533 celeron/abit be6-II 
	ibm 40gv 5400rpm disk, using dma, not on ata66 controller
	384mb ram

thanks in advance,

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
