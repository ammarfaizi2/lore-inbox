Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbRFGVcB>; Thu, 7 Jun 2001 17:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263245AbRFGVbv>; Thu, 7 Jun 2001 17:31:51 -0400
Received: from laxmls04.socal.rr.com ([24.30.163.18]:63983 "EHLO
	laxmls04.socal.rr.com") by vger.kernel.org with ESMTP
	id <S263232AbRFGVbm>; Thu, 7 Jun 2001 17:31:42 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Shane Nay <shane@minirl.com>
To: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>
Subject: Re: Break 2.4 VM in five easy steps
Date: Thu, 7 Jun 2001 14:31:44 -0700
X-Mailer: KMail [version 1.2]
Cc: Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
In-Reply-To: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <0106071431441C.32519@compiler>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uh, last I checked on my linux based embedded device I didn't want to swap to 
flash.  Hmm.., now why was that..., oh, that's right, it's *much* more 
expensive than memory, oh yes, and it actually gets FRIED when you write to a 
block more than 100k times.  Oh, what was that other thing..., oh yes, and 
its SOLDERED ON THE BOARD.  Damn..., guess I just lost a grand or so.

Seriously folks, Linux isn't just for big webservers...

Thanks,
Shane Nay.
(Oh, BTW, I really appreciate the work that people have done on the VM, but 
folks that are just talking..., well, think clearly before you impact other 
people that are writing code.)

On Wednesday 06 June 2001 02:57, Dr S.M. Huen wrote:
> On Wed, 6 Jun 2001, Sean Hunter wrote:
> > For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
>
> Do I understand you correctly?
> ECC grade SDRAM for your 8GB server costs £335 per GB as 512MB sticks even
> at today's silly prices (Crucial). Ultra160 SCSI costs £8.93/GB as 73GB
> drives.
>
> It will cost you 19x as much to put the RAM in as to put the
> developer's recommended amount of swap space to back up that RAM.  The
> developers gave their reasons for this design some time ago and if the
> ONLY problem was that it required you to allocate more swap, why should
> it be a priority item to fix it for those that refuse to do so?   By all
> means fix it urgently where it doesn't work when used as advised but
> demanding priority to fixing a problem encountered when a user refuses to
> use it in the manner specified seems very unreasonable.  If you can afford
> 4GB RAM, you certainly can afford 8GB swap.
