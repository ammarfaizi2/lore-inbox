Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSGHWLD>; Mon, 8 Jul 2002 18:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSGHWLC>; Mon, 8 Jul 2002 18:11:02 -0400
Received: from [209.184.141.189] ([209.184.141.189]:51384 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317189AbSGHWLB>;
	Mon, 8 Jul 2002 18:11:01 -0400
Subject: Re: DELL array controller access.
From: Austin Gonyou <austin@digitalroadkill.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt_Domsch@Dell.com, dtroth@bellsouth.net, linux-kernel@vger.kernel.org
In-Reply-To: <E17RdTp-0002re-00@the-village.bc.nu>
References: <E17RdTp-0002re-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 08 Jul 2002 17:13:37 -0500
Message-Id: <1026166417.16788.0.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know at a minimum...those cards can be put into a 154x mode, so it
will work. I remember that NetWare needed this feature.


On Mon, 2002-07-08 at 13:43, Alan Cox wrote:
> > > RedHat 7.0 and it does not see the board.  Where can I get a 
> > > EISA buss AHA-154x driver to access the array controller?
> > 
> > David, Dell never produced a Linux device driver for the Dell SCSI Array
> > card.  I had forgotten about the AHA-154x emulation feature, but since it
> > doesn't seem to work, it's unlikely that it ever will.  Everyone who worked
> > on that project 9 years ago has left for other opportunities.  The on-board
> > NCR SCSI controller should still work, and you can use software RAID quite
> > easily to accomplish similar functionality.
> 
> The EISA bus AHA154x equivalent is the AHA174x which we do support. I don't
> know what the Dell arrays used however
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
