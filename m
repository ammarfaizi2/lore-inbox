Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751980AbWCBJBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbWCBJBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWCBJBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:01:00 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:43234 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751977AbWCBJA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:00:59 -0500
Date: Thu, 2 Mar 2006 10:00:57 +0100
From: Sander <sander@humilis.net>
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>,
       Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>,
       Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Message-ID: <20060302090057.GC8570@favonius>
Reply-To: sander@humilis.net
References: <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com> <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com> <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com> <44065C7C.6090509@pobox.com> <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com> <44066132.4010205@pobox.com> <44066378.1080408@rtr.ca> <44066400.6070503@pobox.com> <311601c90603012223j10aef3e0s3158567594bb9791@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311601c90603012223j10aef3e0s3158567594bb9791@mail.gmail.com>
X-Uptime: 08:36:57 up 3 days, 14:28, 18 users,  load average: 3.37, 2.89, 2.75
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote (ao):
> On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Mark Lord wrote:
> > > Jeff Garzik wrote:
> > > ..
> > >
> > >> Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is
> > >> the way to go...
> > >
> > >
> > > Might as well add sata_mv to that blacklist as well.
> >
> > Have you confirmed that it doesn't work with FUA?
> 
> I'll see if I can find one of these around the lab tomorrow and test
> the raw command support. If that's fine at a basic level, it might be
> a bug in the driver?

If you tell me what to do (what to type in etc) I can save you from
looking for one. I have a:

Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller
(rev 09)

I can connect a Maxtor MaXLine Pro 500, a Maxtor DiamondMax11 and a WD
Raptor 74GB to test if necessary.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
