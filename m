Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTLVXXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTLVXWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:22:52 -0500
Received: from bay8-dav46.bay8.hotmail.com ([64.4.26.18]:3338 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264540AbTLVXWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:22:48 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Tue, 23 Dec 2003 00:22:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE64A6E.2020506@comcast.net>
Thread-Index: AcPILFxZNqbh0DyuRvOqRSlv1r76oQAtdm5Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV469LcDWYTMq000109ac@hotmail.com>
X-OriginalArrivalTime: 22 Dec 2003 23:22:45.0333 (UTC) FILETIME=[81432050:01C3C8E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just downloaded and compiled the 2.4.18 kernel and it works perfectly. It
must have something to with any changes from 2.4.18 - 2.4.23. I will try
which version up until 2.4.23 that works. I'll keep you posted. Do you know
who I should send this "bug" to in order to get it fixed in the next 2.4.x
version?

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
