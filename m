Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289057AbSAUFty>; Mon, 21 Jan 2002 00:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289061AbSAUFr5>; Mon, 21 Jan 2002 00:47:57 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289064AbSAUFq7>; Mon, 21 Jan 2002 00:46:59 -0500
Date: Fri, 18 Jan 2002 11:40:44 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andre Hedrick <andre@linuxdiskcert.org>, Jens Axboe <axboe@suse.de>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <Pine.LNX.4.40.0201181146100.934-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.10.10201181138500.4260-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Davide Libenzi wrote:

> > > multcount               8               0               8               rw
> >
> > There is a / 2 factor here, thus reality is 16,0,16
> 
> Guys, instead of requiring an -m8 to every user that is observing this
> problem, isn't it better that you limit it inside the driver until things
> gets fixed ?

Yes, and is more fun than it sounds.  The original driver alway checked
for max-capabilities and set accordingly, but things have changed.

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

