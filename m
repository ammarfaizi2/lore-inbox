Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132672AbRDQUjb>; Tue, 17 Apr 2001 16:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132655AbRDQUjW>; Tue, 17 Apr 2001 16:39:22 -0400
Received: from denise.shiny.it ([194.20.232.1]:37827 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S132644AbRDQUjK>;
	Tue, 17 Apr 2001 16:39:10 -0400
Message-ID: <3ADB4511.E3F6F6F1@denise.shiny.it>
Date: Mon, 16 Apr 2001 21:16:33 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: lna@bigfoot.com
Subject: Re: I can eject a mounted CD
In-Reply-To: <3AD779CB.ED7C1656@denise.shiny.it> <3AD78C81.51D8ED35@lvcm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > My fstab:
> >
> > /dev/cdrom              /mnt/cdrom              iso9660
> > noauto,user,ro           0 0
> > /dev/cdrom              /mnt/cdmac              hfs
> > noauto,user,ro           0 0
> 
> Change your fstab to read instead:
> 
> /dev/cdrom        /mnt/cdrom        auto        noauto,user,ro    0 0
> 
> And remove the other cdrom listing. This will allow mounting any
> supported format and eliminate the duel support for one device.

That's not the point. The kernel should not allow someone to
eject a mounted media.



Bye.


