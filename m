Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVGKAfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVGKAfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVGKAKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:10:03 -0400
Received: from smtp2.nbnz.co.nz ([202.49.143.67]:34060 "HELO smtp2.nbnz.co.nz")
	by vger.kernel.org with SMTP id S262050AbVGKAHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 20:07:32 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C334F937B@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: "'Alan Stern'" <stern@rowland.harvard.edu>,
       "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
Cc: Stefano Rivoir <s.rivoir@gts.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] Kernel unable to read partition table on US
	B Memory Key
Date: Mon, 11 Jul 2005 12:07:03 +1200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back again!  (had a 2 day course last week).

> > There are three delays from my patch in the above list,
> 
> Yes.  Why are there three instead of just one?  The 
> sd_revalidate_disk routine should only be called once 
> (although a bug in recent kernels causes it to be called twice).

Don't know; just call them as I see them.

> >  and increasing the
> > delay to 3 seconds didn't help, as I got three one-second delays.  
> 
> I don't understand.  Why didn't you get three three-second delays?

I did, I just can't type.  Sorry.

> Can you try adding delays before, after, and inbetween the 
> calls to sd_read_capacity, sd_read_write_protect_flag, and 
> sd_read_cache_type, all near the end of sd_revalidate_disk?

Yes, will do this and post results.

> > Note that I now have the output from the USB Snoop tool 
> under Windows 
> > if anyone wants it - please ask if needed to help solve the 
> issue "correctly".
> 
> Can you make it available on a web or ftp site and post the 
> URL for interested parties?

(Smacks head)  Why didn't I think of that?

http://users.actrix.co.nz/rtfamily/USBLog1.usblog.bz2 for the Snoopy tool
output and
http://users.actrix.co.nz/rtfamily/USBDebugMsgs.bz2 for the other output I
emailed to this list last week.

Thanks,

James Roberts-Thomson
----------
Hardware:  The parts of a computer system that can be kicked.

Mailing list Readers:  Please ignore the following disclaimer - this email
is explicitly declared to be non confidential and does not contain
privileged information.

This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
