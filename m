Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289055AbSAUFtw>; Mon, 21 Jan 2002 00:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289058AbSAUFrw>; Mon, 21 Jan 2002 00:47:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289062AbSAUFq6>; Mon, 21 Jan 2002 00:46:58 -0500
Date: Fri, 18 Jan 2002 11:44:16 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jens Axboe <axboe@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <Pine.LNX.4.40.0201181146100.934-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.10.10201181143090.4260-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Davide Libenzi wrote:

> On Fri, 18 Jan 2002, Andre Hedrick wrote:
> > > multcount               8               0               8               rw
> >
> > There is a / 2 factor here, thus reality is 16,0,16
> 
> Guys, instead of requiring an -m8 to every user that is observing this
> problem, isn't it better that you limit it inside the driver until things
> gets fixed ?

Better yet is to # out CONFIG_IDEDISK_MULTI_MODE option in Config.in for
now.

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


