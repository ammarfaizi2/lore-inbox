Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314525AbSEUN1t>; Tue, 21 May 2002 09:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSEUN1s>; Tue, 21 May 2002 09:27:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42514 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314525AbSEUN1s>; Tue, 21 May 2002 09:27:48 -0400
Subject: Re: IO stats in /proc/partitions
To: dwguest@win.tue.nl (Guest section DW)
Date: Tue, 21 May 2002 14:11:45 +0100 (BST)
Cc: davidsen@tmr.com (Bill Davidsen), alan@lxorguk.ukuu.org.uk (Alan Cox),
        miquels@cistron.nl (Miquel van Smoorenburg),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020521003604.GA400@win.tue.nl> from "Guest section DW" at May 21, 2002 02:36:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17A9QX-0007ky-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   Changes belong in 2.5, /proc/partitions is the wrong place, but it's
> > also the place the tools expect. I hope that's not going to change in the
> > stable kernel.
> 
> You misunderstand.
> Everybody agrees that /proc/partitions is the wrong place.
> Up to now these statistics have not been part of any official
> kernel, stable or not.

The 2.4 stable kernel is the minority product here 8)

> However, someone wanted to introduce them for the first time
> in 2.4.19 and put them in /proc/partitions. That is a really bad idea,
> especially when they will be somewhere else in 2.5.

I agree. Its relatively easy for vendors to keep the stats in /proc/partitions
for 2.4.x (certainly adding other stuff instead to proc/partitions for 2.4
is bad). It is better that people are encouraged to use a new 2.5 compatible
interface over time and for later 2.4.x that vendors ship something with
both.

Alan
