Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263669AbRFFRXl>; Wed, 6 Jun 2001 13:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFFRXb>; Wed, 6 Jun 2001 13:23:31 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:28689 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S263669AbRFFRXO>; Wed, 6 Jun 2001 13:23:14 -0400
Date: Wed, 6 Jun 2001 19:17:26 +0200
From: Kurt Roeckx <Q@ping.be>
To: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>
Cc: Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606191726.B421@ping.be>
In-Reply-To: <20010606095431.C15199@dev.sportingbet.com> <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 10:57:57AM +0100, Dr S.M. Huen wrote:
> On Wed, 6 Jun 2001, Sean Hunter wrote:
> 
> > 
> > For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
> > 
> 
> Do I understand you correctly?
> ECC grade SDRAM for your 8GB server costs £335 per GB as 512MB sticks even
> at today's silly prices (Crucial). Ultra160 SCSI costs £8.93/GB as 73GB
> drives.

Maybe you really should reread the statements people made about
this before.

One of them being, that if you're not using swap in 2.2, it won't
need any in 2.4 either.

2.4 will use more swap in case it does use it.  It now works more
like other UNIX variants where the rule is that swap = 2 * RAM.

That swap = 2 * RAM is just a guideline, you really should look
at what applications you run, and how memory they use.  If you
choise your RAM so that all application can always be in memory
at all time, there is no need for swap.  If they can't be, the
rule might help you.

I think someone said that the swap should be large enough to hold
all application that are running on swapspace, that is, in case
you want to use swap.

Disk maybe be alot cheaper than RAM, but it's also alot slower.


Kurt

