Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263294AbSJFDoS>; Sat, 5 Oct 2002 23:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263296AbSJFDoS>; Sat, 5 Oct 2002 23:44:18 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60689
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263294AbSJFDoR>; Sat, 5 Oct 2002 23:44:17 -0400
Date: Sat, 5 Oct 2002 20:47:21 -0700 (PDT)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
In-Reply-To: <3D9FB053.4040001@candelatech.com>
Message-ID: <Pine.LNX.4.10.10210052045090.22517-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a pair of Compaq e1000's which have never overheated, and I use
them for heavy duty iSCSI testing and designing of drivers.  These are
massive 66/64 cards but still nothing like what you are reporting.

I will look some more at the issue soon.

Cheers,

Andre Hedrick
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/


On Sat, 5 Oct 2002, Ben Greear wrote:

> I believe I have figured out why the e1000 crashed my machine
> after .5 - 1 hours:  The NIC was over-heating.  I measured one of
> the NICs after the machine crashed with an external (cheap) temp
> probe.  It registered right at 50 degrees C, and this was about 15-30
> seconds after it crashed.
> 
> The dual e1000 NIC I have seems to run much cooler, and has been
> running at 430Mbps bi-directional on both ports for about 6 hours now
> with no obvious problems.
> 
> So, I'm going to try to purchase some heat sinks and glue them onto
> the e1000 server nics, to see if that fixes the problem.
> 
> Hope this proves useful to anyone experiencing similar strange
> crashes!
> 
> Thanks,
> Ben
> 
> -- 
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

