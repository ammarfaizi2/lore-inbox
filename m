Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269864AbUJTKxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269864AbUJTKxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269401AbUJTKwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:52:03 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:26499 "EHLO
	beast.stev.org") by vger.kernel.org with ESMTP id S269864AbUJTKov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:44:51 -0400
Date: Wed, 20 Oct 2004 12:18:02 +0100 (BST)
From: James Stevenson <james@stev.org>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <kernelnewbies@nl.linux.org>, James Stevenson <james@stev.org>
Subject: Re: ATA/133 Problems with multiple cards
In-Reply-To: <200410201235.37423.hpj@urpla.net>
Message-ID: <Pine.LNX.4.44.0410201211481.5805-100000@beast.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Hans-Peter Jansen wrote:

> [Heavily stripped address lists]
> 
> On Sunday 17 October 2004 04:51, James Stevenson wrote:
> >
> > then i can only turn the dma up to ATA/100 if i set it to ata/133
> > it will cause the errors. I assume this is something todo with the
> > promise bois not setting up the 3rd card at boot time. It only
> > shows drive listing for 2 of the 3 cards.
> 
> As noted before, this effect was always related to different firmware 
> versions on the cards here. Please check boot messages of all cards 
> separately, and confirm, that this isn't your problem.

I had them all flashed to the latest current version which was 2.20.0.15
when i started having problems. Each card was verified to that version as 
well. Some did have older firmware on them.

The same problems were seen before / after flashign the card. As far as i 
could tell the promise bios will run form the first card and init the 
other cards it could be configuring something there which nobody else is 
aware of. However this only showed drives / drive interfaces form the 
first 2 cards never the 3rd card. After the bios has init'ed the carss 
the bios doesnt run on any other cards.

When booting the machine will 3 cards and no drives attached the bios is 
loaded and unloaded 3 times. This is why i belave something is getting 
enable / disabled on the other cards by the bios.

	James


-- 
--------------------------
Mobile: +44 07779080838
http://www.stev.org
 12:10pm  up 19:08,  5 users,  load average: 3.90, 3.83, 3.49

