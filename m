Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264894AbUFHI3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUFHI3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 04:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbUFHI3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 04:29:08 -0400
Received: from mail.wdsl.co.za ([196.28.86.3]:51690 "EHLO
	mail.uninetwork.co.za") by vger.kernel.org with ESMTP
	id S264894AbUFHI3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 04:29:02 -0400
Subject: RESOLUTION: Re: Multiple CDR's on a system
From: Hamish Whittal <hamish@QEDux.co.za>
Reply-To: hamish@QEDux.co.za
To: Sean Reifschneider <jafo@tummy.com>
Cc: tkil@scrye.com, gadio@netvision.net.il, linux-kernel@vger.kernel.org
In-Reply-To: <20040607222348.GA13135@tummy.com>
References: <1086082197.925.98.camel@defender.QEDux.co.za>
	 <16572.13798.359212.869454@brand.scrye.com>
	 <20040607222348.GA13135@tummy.com>
Content-Type: text/plain
Organization: QED Technologies cc
Message-Id: <1086690890.919.73.camel@defender.QEDux.co.za>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 08 Jun 2004 10:34:50 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean, Tkil, Gadi and others....

Here is my take on the multiple CDR's in a single machine:

Thanks for the replies people.....
> a box that had enough RAM to buffer an entire ISO (Athlon XP 1700+ with
> 1GB of RAM).
WOW. My machine only has 512Mb of RAM. So no chance of storing entire CD
in memory. I did consider this, but then abandoned that idea.
> 
> We have found that we also run into lots of problems if we don't store
> the ISO on a DeskStar hard drive.  Particularly, slower hard drives seem
I have a Seagate 7200RPM drive. It seems to be able to keep up
sufficiently with the burning process, so I don't think the problem is
that. I did have AOpen CD writers, which I upgraded to the latest BIOS
version, thinking this may have been the problem. Alas, so joy. They
worked even worse that the older BIOS  version - I ask, how can that be?
Surely software upgrades should make things BETTER, not worse! But there
again, that is a MS trend (;

> to cause more problems with burns.  We've mostly given up on trying to
> get multiple drives burning in one system.
I have now switched to Giagbyte CD writers (as much crap as the Aopen,
but what can I do?). At least the burns are working fine now. I verify
with 'dd' and then check out the checksum. They seem to be checking out
and I seem to be able to install from them no problem. You CANNOT
believe how much time this has taken to get this working....or maybe you
can!!!!!

I have narrowed it down to the following:
It seems that the problems occur not with the writing process, but with
the 'Fixation' process. I have now adopted the approach of NOT fixating
the CD's until they have all completed a burn. Then, before ejecting, I
Fixate them one at a time. Once done, I eject the CD's. I have had quite
a couple of successes with this, so without giving the definitive
'THUMBS UP', I think it we seem to be cooking with gas.

> 
> I did try at one point doing a burn on a discless client, and got it to
Can't go there I am afraid. A single machine is all I have. I am not
sure how I will bill the client now for all this time, effort and CDR's
I've toasted - um sorry 'coaster ed'......but that's another story.

> >The one other thing I might suggest is trying out a 2.6 kernel with
> >the cdrecord version patched to work with DMA.
I did this. It seems to have solved some problems with the CD's bombing
out early on. I have a Promise PCI IDE card driving 2 burners and the
on-board 2ndary controller driving the first CD writer. It seems that
any other config does not work. All burners are masters with NO slaves
on the same cable.

Finally, I made sure the IDE cables were these 'new' ATA type (80 pin).
I am not sure whether this helped, but I wanted to eliminate all
possibilities.

So the upshot. I have got all 3 writers burning simultaneously. It would
be interesting to see whether I could build a similar system and whether
it would co-operate - or whether this was just luck (;

Cheers
Hamish

