Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTLWA7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTLWA7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:59:48 -0500
Received: from bay8-dav18.bay8.hotmail.com ([64.4.26.122]:49161 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264880AbTLWA7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:59:46 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Tue, 23 Dec 2003 01:59:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE64A6E.2020506@comcast.net>
Thread-Index: AcPILFxZNqbh0DyuRvOqRSlv1r76oQAwy1/A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV18eeADZVX6Q0000db55@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2003 00:59:44.0467 (UTC) FILETIME=[0DBC8230:01C3C8F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually the 2.4.18 seems to be the only one working. I'm sure someone out
there have the proper fix for this. Who should I talk to in order to get
this fixed? I'm willing to help out in any way I can.

/Nicke 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 22 december 2003 02:36
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Nicklas Bondesson wrote:
> Now I'm sucessfully booting my system with the 2.4.23 kernel using 
> only one of the drives (hde). There is not a single line in the logs 
> that says anything about the Promise ATARAID driver is beeing fired 
> up, so my guess is that it doesn't load if no one is calling on it. 
> When I try to boot from the RAID it dies right after the "NET4: Unix
domain sockets 1.0/SMP for Linux"
> message. I think it's when the ATARAID driver is about to fire up. I 
> have no idea at all what to do now. It must have something to do with 
> the hard drives since this is the only thing that has changed. Maybee 
> I'm missing some important kernel setting option or so? (I don't think 
> so, but one never know for sure). Also what have changed in the 
> Promise / ATARAID since 2.4.18?.
> 
> /Nicke

Not sure what else to tell you. If the pdcraid driver is compiled into the
kernel, you'll get a message about it during boot, even if it can't find all
the drives. I no longer use the 2.4 kernel series (or pdcraid), so I'm
afraid I'm out of ideas. Maybe somebody else on the list has some other
things to try. Sorry.

-Walt



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
