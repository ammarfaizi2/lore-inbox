Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281591AbRKSApJ>; Sun, 18 Nov 2001 19:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281861AbRKSApA>; Sun, 18 Nov 2001 19:45:00 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:517 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281591AbRKSAoq>;
	Sun, 18 Nov 2001 19:44:46 -0500
Message-Id: <5.1.0.14.0.20011119113205.01eb7dc0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 19 Nov 2001 11:44:42 +1100
To: <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
Cc: John Jasen <jjasen1@umbc.edu>, Anders Peter Fugmann <afu@fugmann.dhs.org>
In-Reply-To: <Pine.SGI.4.31L.02.0111181650580.12243284-100000@irix2.gl.u
 mbc.edu>
In-Reply-To: <3BF82B1E.8090305@fugmann.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:55 PM 18/11/01 -0500, John Jasen wrote:
>labrat5+linux2.2.19 = decent response times
>labrat6+linux2.2.19 = decent response times
>firewall system + linux2.2.19 = decent response time
>
>labrat5+linux2.4.x, where X=4,7,12 = painfully slow
>labrat6+linux2.4.x, where X=4,7,12 = painfully slow
>firewall system + linux2.4.x, where X=7 = painfully slow

Have you tried going through with hdparm enabling/disabling the options in 
turn? eg: DMA, Unmasq IRQ, Multi-Count, etc.

I would not be surprised if what was happening was related to DMA causing 
huge locks of the IDE subsystem, and dragging out the disk times, therefore 
throwing the system out the window. Out of your previous posts, I saw you 
mention you fiddled with Unmasq IRQ and 32 bit, but not DMA.

Also are these systems per chance running the same brand/model of h/drive? 
While I doubt it, could this be a problem with these drives and these 
boards only in certain modes?

Good luck!


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

