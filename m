Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbTHOQ0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269512AbTHOQZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:25:56 -0400
Received: from ida.rowland.org ([192.131.102.52]:22276 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S269451AbTHOQZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:25:04 -0400
Date: Fri, 15 Aug 2003 12:25:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Gene Heskett <gene.heskett@verizon.net>
cc: Peter Denison <lkml@marshadder.uklinux.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.4.21 USB printer failure w/ HP PSC750
In-Reply-To: <200308151037.32368.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.44L0.0308151220030.1137-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003, Gene Heskett wrote:

> I can confirm that this does not appear to be printer related, this 
> nearly exact scenario just happened to me while running test3-mm2.  So 
> I powered down the printer, in this case an Epson C82 being driven by 
> cups, and then rebooted to 2.4.22-rc2.  Where it also refused to 
> print, until I went to the local cups page and "started" both 
> printers, which had been apparently disabled by the above failure and 
> it carried over the reboot from 2.6.0-test3-mm2 to 2.4.22-rc2.  Once 
> the printer was 'started' then the 3 jobs I'd sent were spit right out 
> normally.
> 
> It appears that usblp still has problems as of 2.6.0-test3-mm2.

There was a recent change to usblp for 2.6.0, reversing a prior patch 
which broke the driver somehow.  See

http://sourceforge.net/mailarchive/forum.php?thread_id=2931846&forum_id=5398

I don't know whether or not this change is already incorporated in the
version you're using.

Alan Stern

