Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbTLVNiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 08:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264910AbTLVNiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 08:38:25 -0500
Received: from bay8-dav19.bay8.hotmail.com ([64.4.26.123]:21010 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264891AbTLVNiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 08:38:23 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>, <linux-kernel@vger.kernel.org>
Cc: <andre@linux-ide.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Mon, 22 Dec 2003 14:38:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE64A6E.2020506@comcast.net>
Thread-Index: AcPILFxZNqbh0DyuRvOqRSlv1r76oQAY5GQg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV19JuYW8iOqz00010341@hotmail.com>
X-OriginalArrivalTime: 22 Dec 2003 13:38:22.0554 (UTC) FILETIME=[DE37A3A0:01C3C890]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do I have to include anything else than this??

<*> ATA/IDE/MFM/RLL support
  IDE, ATA and ATAPI Block devices -->
	<*> PROMISE PDC202{68|69|70|71|75|76|77} support (NEW)
	[*] Special FastTrack Feature

	<*> Support for IDE Raid Controllers (EXPERIMENTAL)
	<*> Support Promise software RAID (Fasttrak(tm)) (EXPERIMENTAL)
 
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
