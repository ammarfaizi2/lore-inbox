Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278082AbRJPDvx>; Mon, 15 Oct 2001 23:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278084AbRJPDve>; Mon, 15 Oct 2001 23:51:34 -0400
Received: from c009-h018.c009.snv.cp.net ([209.228.34.131]:57297 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S278082AbRJPDvb>;
	Mon, 15 Oct 2001 23:51:31 -0400
X-Sent: 16 Oct 2001 03:51:58 GMT
Date: Mon, 15 Oct 2001 20:53:23 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: very slow RAID-1 resync
In-Reply-To: <15307.44327.541413.250400@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.33.0110152052510.415-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, Neil Brown wrote:

> On Monday October 15, hahn@physics.mcmaster.ca wrote:
> > > raid1d and raid1syncd are barely getting any CPU time on this otherwise
> > > idle SMP system.
> >
> > I noticed this too, on a uni, raid5 system;
> > the resync-throttling code doesn't seem to work well.
>
> It works great for me...
> What sort of drives do you have? SCSI? IDE? are you using both master
> and slave on an IDE controller?

15,000 RPM SCSI u160 disks.

-jwb

