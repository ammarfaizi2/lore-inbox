Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbTC1DLl>; Thu, 27 Mar 2003 22:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbTC1DLk>; Thu, 27 Mar 2003 22:11:40 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8966 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261994AbTC1DLj>; Thu, 27 Mar 2003 22:11:39 -0500
Date: Thu, 27 Mar 2003 19:19:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.5.66 bio traversal + IDE PIO patches on the way
In-Reply-To: <1048809404.3952.6.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10303271917450.25072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan, use it -- it works.

Bart and I argued and debated the model back when MD was around.
I spent time explain the issues in the state machine and Bart got it.
Then I spent time with him and Suparna to work out the BIO issues.
Jens chimed in with the need changes to address our needs.

Try it before you wank on it!

On 27 Mar 2003, Alan Cox wrote:

> On Thu, 2003-03-27 at 23:46, Bartlomiej Zolnierkiewicz wrote:
> > 2.5.66-ide-pio-1-A0.diff
> > 2.5.66-ide-pio-2-A0.diff
> > and turn on IDE_TASKFILE_IO config option in IDE menu
> > 
> > As always with block or IDE changes special care is _strongly_
> > recommended, don't blame me if it eats your fs :-).
> 
> The IDE taskfile stuff for I/O is known broken. Thats why it
> is currently disabled. I plan to keep it that way until 2.7
> 
> 

Andre Hedrick
LAD Storage Consulting Group

