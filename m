Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135686AbRDSUdJ>; Thu, 19 Apr 2001 16:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135692AbRDSUc7>; Thu, 19 Apr 2001 16:32:59 -0400
Received: from s340-modem3054.dial.xs4all.nl ([194.109.171.238]:8840 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S135686AbRDSUcr>;
	Thu, 19 Apr 2001 16:32:47 -0400
Date: Thu, 19 Apr 2001 23:13:49 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: <linux-lvm@sistina.com>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] 2.4.3-ac{6,7} LVM hang
In-Reply-To: <Pine.LNX.4.21.0104161653140.14442-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.31.0104192311080.1048-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Same here as reported.
restoring lvm.c from 2.4.3 into 2.4.4-pre? "fixes" this. (tested not ac's
kernel)

Greatings,

On Mon, 16 Apr 2001, Rik van Riel wrote:

> Hi,
>
> 2.4.3-ac4 seems to work great on my test box (UP K6-2 with SCSI
> disk), but 2.4.3-ac6 and 2.4.3-ac7 hang pretty hard when I try
> to access any of the logical volumes on my test box.
>
> The following changelog entry in Linus' changelog suggests me
> whom to bother:   ;)
>  - Jens Axboe: LVM and loop fixes
>
> regards,
>
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
>
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com.br/
>
> _______________________________________________
> linux-lvm mailing list
> linux-lvm@sistina.com
> http://lists.sistina.com/mailman/listinfo/linux-lvm
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

