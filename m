Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752492AbVHGSIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbVHGSIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbVHGSIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:08:04 -0400
Received: from mx1.rowland.org ([192.131.102.7]:42501 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1752492AbVHGSID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:08:03 -0400
Date: Sun, 7 Aug 2005 14:08:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: martin.maurer@email.de
cc: Martin Maurer <martinmaurer@gmx.at>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>,
       PeteZaitcev <zaitcev@redhat.com>
Subject: Re: Fw: Re: Elitegroup K7S5A + usb_storage problem
In-Reply-To: <816070633@web.de>
Message-ID: <Pine.LNX.4.44L0.0508071400290.32668-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2005 martin.maurer@email.de wrote:

> Hi Alan,
> 
> no. the stick doesn't have a write protection switch.
> Once when i tried to copy a file to the mp3 player i got a new file there on remount,
> but it consisted of incorrect data. (so writing seemed to be possible and just went wrong)
> (in that case the fat seemed to be damaged after i had tried this, so that windows wasn't 
> able to read it correctly any more.
> (formatting from the mp3 players menu helped)

Well, perhaps the device isn't consistently writing data to the 
correct locations.

> greetings
> Martin
> 
> PS: just as an info - i sent a usbmon trace to Pete Zaitcev today, should I send it to you too? 

Pete is quite as competent at solving this kind of problem as I am.  And
he knows the ub driver much better, so I'm happy to bow out and let him
worry about it!  :-)

Just out of curiosity, if you plug the player into a Windows system 
without installing any special drivers first, will Windows be able to read 
and write files okay?  If it can, a USB packet trace may give Pete a clue 
as to where to look.

Alan Stern

