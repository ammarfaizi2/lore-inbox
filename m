Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUJTOml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUJTOml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJTOik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:38:40 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:54912 "EHLO
	beast.stev.org") by vger.kernel.org with ESMTP id S268483AbUJTOfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:35:44 -0400
Date: Wed, 20 Oct 2004 16:08:59 +0100 (BST)
From: James Stevenson <james@stev.org>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <kernelnewbies@nl.linux.org>
Subject: Re: ATA/133 Problems with multiple cards
In-Reply-To: <200410201623.21321.hpj@urpla.net>
Message-ID: <Pine.LNX.4.44.0410201606250.1639-100000@beast.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > I had them all flashed to the latest current version which was
> > 2.20.0.15 when i started having problems. Each card was verified to
> > that version as well. Some did have older firmware on them.
> >
> > The same problems were seen before / after flashign the card. As
> > far as i could tell the promise bios will run form the first card
> > and init the other cards it could be configuring something there
> > which nobody else is aware of. However this only showed drives /
> > drive interfaces form the first 2 cards never the 3rd card. After
> > the bios has init'ed the carss the bios doesnt run on any other
> > cards.
> 
> Yes, this is true, but shouldn't harm. See below.
> 
> > When booting the machine will 3 cards and no drives attached the
> > bios is loaded and unloaded 3 times. This is why i belave something
> > is getting enable / disabled on the other cards by the bios.
> 
> Hmm, I'm running 3 TX2/100 (even with different revisions) without 
> big problems here:
> 
> 00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
> 00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
> 00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 01)
> 
> 
> Besides these error messages, the drives seem to work fine, although 
> as I investigated now, the dma modes look strange:

<snip dmesg / drive info>

> 
> Also strange..
> 
> These drives on the third controller are used only sporadic. 
> The first 4 build a RAID5 array with hot spare and are used 
> heavily (main server for diskless clients, mail, imap, samba, 
> etc...) and the system sports 67 days uptime ATM :-).

Yeah thats what i had although when i tried to write to both disks on the
3rd controller (1 disk on each channel) the machine would lockup
do you see the same problem ?

also note that the card i have are a 20269 yours are a 20268
which is slightly different.


-- 
--------------------------
Mobile: +44 07779080838
http://www.stev.org
  4:00pm  up  2:26,  3 users,  load average: 3.72, 3.77, 3.72

