Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbSAUQom>; Mon, 21 Jan 2002 11:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287401AbSAUQod>; Mon, 21 Jan 2002 11:44:33 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31412 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287388AbSAUQoZ>; Mon, 21 Jan 2002 11:44:25 -0500
To: Mike Phillips <phillim2@home.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Mike Phillips <phillim@home.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA6159B1C.9D145D7A-ON85256B48.005BBAF9@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Mon, 21 Jan 2002 10:44:20 -0600
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/21/2002 11:44:21 AM,
	Serialize complete at 01/21/2002 11:44:21 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,
        Did you tweak the card's PCI config area to fix this problem, or 
elsewhere?

Kent



> Kent,
> 
> We had this on olympic for certain high end IBM boxen. Spent forever
> trying to trap it as I couldn't emulate the behaviour on my test
> boxes. We weren't getting correct values from pci reads/write and we
> were running out of buffers as they weren't getting flushed. The
> machine wouldn't lock but the adapter would stop tx/rx.
> 
> Turned out the pci bridge on the machine itself was causing the
> problems. Tweaking the pci bus fixed the problem. 





