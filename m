Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTL1Vfj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 16:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTL1Vfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 16:35:39 -0500
Received: from litaipig.ucr.edu ([138.23.89.48]:50126 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id S262074AbTL1Vfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 16:35:37 -0500
Date: Sun, 28 Dec 2003 13:35:35 -0800
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Message-ID: <20031228213535.GA21459@mail-infomine.ucr.edu>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <Pine.LNX.4.44.0312281032350.21070-100000@twin.uoregon.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312281032350.21070-100000@twin.uoregon.edu>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Joel Jaeggli:
> well if you currently have 1tb in 8 non-redundant drives then you using 
> 160GB disks... no?
> 
> the biggest p-ata disks right now are ~320GB so you can do a ~1TB software 
> raid 5 stripe on a single 4 port ata controller such as a promise tx4000 
> using regular software raid rather than the promise raid. that would end 
> up being fairly inexpensive and buy you more protection.

Fisrt of all: thanks for the advice Joel!  Two questions: why not use the
hardware raid capability of the Promise tx4000 and if we'd use software
raid instead, what would be the CPU overhead?

> 
> linux software raid hsa been as releiable as anything else we've used over 
> the years, the lack of reliabilitiy in your situation will come entirely 

Good to hear.

> from failing disks, lose one and your filesystem is toast.

I was aware of that, thanks!

> 
> joelja
> 
> On Sun, 28 Dec 2003, Johannes Ruscheinski wrote:
> 
> > Hi,
> > 
> > We're looking for a low-cost high-reliability IDE RAID solution that works well
> > with the 2.6.x series of kernels.  We have about 1 TB (8 disks) that we'd
> > like to access in a non-redundant raid mode.  Yes, I know, that lack of
> > redundancy and high reliability are contradictory.  Let's just say that
> > currently we lack the funding to do anything else but we may be able to obtain
> > more funding for our disk storage needs in the near future.
> > 
> 
> -- 
> -------------------------------------------------------------------------- 
> Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
> GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2
> 

-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

Outlook, n.:
        A virus delivery system with added email functionality.
