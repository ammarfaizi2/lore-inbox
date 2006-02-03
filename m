Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWBCTAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWBCTAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWBCTAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:00:21 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:2326 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1030215AbWBCTAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:00:20 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Martin Drab'" <drab@kepler.fjfi.cvut.cz>,
       "'Phillip Susi'" <psusi@cfl.rr.com>
Cc: "'Bill Davidsen'" <davidsen@tmr.com>, "'Cynbe ru Taren'" <cynbe@muq.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>
Subject: RE: FYI: RAID5 unusably unstable through 2.6.14
Date: Fri, 3 Feb 2006 13:10:51 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <Pine.LNX.4.60.0602031846510.24081@kepler.fjfi.cvut.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYo6e+pkaWo6Q6OTueSxDcWDyrtZgACzn+A
Message-ID: <EXCHG2003KfYDovvQ0P000011f7@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 03 Feb 2006 18:53:36.0579 (UTC) FILETIME=[23955130:01C628F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Martin Drab
> Sent: Friday, February 03, 2006 11:51 AM
> To: Phillip Susi
> Cc: Bill Davidsen; Cynbe ru Taren; Linux Kernel Mailing List; 
> Salyzyn, Mark
> Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
> 
> On Fri, 3 Feb 2006, Martin Drab wrote:
> 
> > On Fri, 3 Feb 2006, Phillip Susi wrote:
> > 
> > > Usually drives will fail reads to bad sectors but when 
> you write to 
> > > that sector, it will write and read that sector to see if 
> it is fine 
> > > after being written again, or if the media is bad in 
> which case it 
> > > will remap the sector to a spare.
> > 
> > No, I don't think this was the case of a physically bad sectors. I 
> > think it was just an inconsistency of the RAID controllers metadata 
> > (or something simillar) related to that particular array.
> 
> Or is such a situation not possible at all? Are bad sectors 
> the only reason that might have caused this? That sounds a 
> little strange to me, that would have been a very unlikely 
> concentration of conincidences, IMO. 
> That's why I still think there are no bad sectors at all (at 
> least not because of this). Is there any way to actually find out?


Some of the drive manufacturers have tools that will read out
"log" files from the disks, and these log files include stuff
such as how many bad block errors where returned to the host
over the life of the disk.

You would need a decent contatct with the disk manufacturer, and
you might be able to get them to tell you, maybe.

                         Roger

