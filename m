Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282491AbRL1Pao>; Fri, 28 Dec 2001 10:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286932AbRL1Paf>; Fri, 28 Dec 2001 10:30:35 -0500
Received: from ns2.q-station.net ([202.66.128.35]:13319 "HELO
	smtp.q-station.net") by vger.kernel.org with SMTP
	id <S282491AbRL1PaY>; Fri, 28 Dec 2001 10:30:24 -0500
Date: Fri, 28 Dec 2001 23:30:19 +0800 (CST)
From: Leung Yau Wai <chris@gist.q-station.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: dd cdrom error
In-Reply-To: <E16Jxiv-0000YJ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10112282328210.7455-100000@gist.q-station.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Dec 2001, Alan Cox wrote:

> > 	BTW, why kernel 2.2.X will success create the ISO image of the
> > same disc with the same command?
> 
> The 2.2 kernel knows that errors in the last few blocks of an ISO image are
> not in fact to be counted as errors and retried. Apparently that got lost
> somewhere. Maybe Jens knows ?

	But, why turning off DMA 'hdparm -d0 /dev/hdd' then everything
work fine? Do you mean if turning off DMA then 2.4 kernel also knows that
errors in the last few blocks of an ISO image are not in fact to be
counted as errors and retried?  Also Jens knows?


Chris


