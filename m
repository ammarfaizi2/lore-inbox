Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289066AbSAUFtx>; Mon, 21 Jan 2002 00:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSAUFrz>; Mon, 21 Jan 2002 00:47:55 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289061AbSAUFq6>; Mon, 21 Jan 2002 00:46:58 -0500
Date: Sat, 19 Jan 2002 03:37:58 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020119124017.G27835@suse.de>
Message-ID: <Pine.LNX.4.10.10201190337010.7770-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2002, Jens Axboe wrote:

> On Fri, Jan 18 2002, Davide Libenzi wrote:
> > Guys, instead of requiring an -m8 to every user that is observing this
> > problem, isn't it better that you limit it inside the driver until things
> > gets fixed ?
> 
> There is no -m8 limit, 2.5.3-pre1 + ata253p1-2 patch handles any set
> multi mode value.
> 
> -- 
> Jens Axboe
> 

And that will generate the [lost interrupt], and I have it fixed at all
levels too now.


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

