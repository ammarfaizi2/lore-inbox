Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131199AbRCGV2H>; Wed, 7 Mar 2001 16:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbRCGV15>; Wed, 7 Mar 2001 16:27:57 -0500
Received: from [216.184.166.130] ([216.184.166.130]:56072 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S131199AbRCGV1q>; Wed, 7 Mar 2001 16:27:46 -0500
Date: Wed, 7 Mar 2001 13:23:49 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: George Garvey <tmwg-linuxknl@inxservices.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
In-Reply-To: <20010307201437.A5030@suse.cz>
Message-ID: <Pine.LNX.3.95.1010307131509.31180A-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Vojtech Pavlik wrote:

> Date: Wed, 7 Mar 2001 20:14:37 +0100
> From: Vojtech Pavlik <vojtech@suse.cz>
> To: George Garvey <tmwg-linuxknl@inxservices.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
> 
> On Tue, Mar 06, 2001 at 05:05:46AM -0800, George Garvey wrote:
> > 
> > > No, just the vt82c686. vt82c686a and vt82c686b are OK.
> > 
> > So can the vt82c686 be replaced with one of these other chips? What
> > action is available to owners of MBs with chips that don't work w/Linux?
> 
> It can be replaced if you can desolder a 352 contact BGA chip. I don't
> know of anyone who does.
> 
> Also, the vt82c686 will work just fine with Linux, but will be limited
> to UDMA33, because UDMA66 on this chip does reliably fail.

Based on following the lkml threads on Via chipsets, it seems that
the 686a at or above rev 22, will run UDMA66 just fine.
Below that, lies the flakiness...
My Tyan based 686a rev 22 has been trouble free save a bad cable.

I just acquired a new 1.1G athlon on an asus a7v133. It has a 686b.
What should I expect w the 686b?  and is the Via 686b data sheet 
available somewhere? 

Thanx

> 
> Furthermore, these chips are very rare - I don't know anyone owning one.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

