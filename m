Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270497AbTHCGXK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 02:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270986AbTHCGXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 02:23:10 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:30219 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270497AbTHCGXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 02:23:08 -0400
From: "Alan Shih" <alan@storlinksemi.com>
To: "Ben Greear" <greearb@candelatech.com>, "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Nivedita Singhvi" <niv@us.ibm.com>,
       "Werner Almesberger" <werner@almesberger.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: TOE brain dump
Date: Sat, 2 Aug 2003 23:22:52 -0700
Message-ID: <ODEIIOAOPGGCDIKEOPILKEKKDAAA.alan@storlinksemi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
In-Reply-To: <3F2C891B.7080004@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A DMA xfer that fills the NIC pipe with IDE source. That's not very hard...
need a lot of bufferring/FIFO though.  May require large modification to the
file serving applications?

Alan

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ben Greear
Sent: Saturday, August 02, 2003 9:02 PM
To: Jeff Garzik
Cc: Nivedita Singhvi; Werner Almesberger; netdev@oss.sgi.com;
linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump


Jeff Garzik wrote:

> So, fix the other end of the pipeline too, otherwise this fast network
> stuff is flashly but pointless.  If you want to serve up data from disk,
> then start creating PCI cards that have both Serial ATA and ethernet
> connectors on them :)  Cut out the middleman of the host CPU and host

I for one would love to see something like this, and not just Serial ATA..
but maybe 8x Serial ATA and RAID :)

Ben


--
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

