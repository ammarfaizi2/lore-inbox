Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVIDBxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVIDBxW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 21:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVIDBxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 21:53:22 -0400
Received: from mx1.rowland.org ([192.131.102.7]:36880 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750798AbVIDBxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 21:53:21 -0400
Date: Sat, 3 Sep 2005 21:53:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Jan De Luyck <lkml@kcore.org>
cc: USB Storage list <usb-storage@lists.one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Genesys USB 2.0 enclosures
In-Reply-To: <200509031812.54753.lkml@kcore.org>
Message-ID: <Pine.LNX.4.44L0.0509032151040.5675-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Sep 2005, Jan De Luyck wrote:

> Hello lists,
> 
> (a mail for the archives)
> 
> I've posted in the past about problems with these enclosures - increasing the 
> delay seems to fix it, albeit temporarily. The further you go in using the 
> disk in such an enclosure, the higher the udelay() had to be - atleast that's 
> what I'm seeing here (I've got two of these now :/ )
> 
> One permanent fix is adding a powered USB-hub in between the drive enclosures 
> and the computer. Since I've done that, I've no longer seen any of the 
> problems (i've attached the 'fault' log). Weird but true, since the drives 
> come with their own powersupply.
> 
> Hope this helps anyone in the future running into the same problem.

This one certainly goes into the Bizarro file.

Just out of curiosity -- when you use the powered hub, does the drive work 
even if you remove that delay completely?

Alan Stern

