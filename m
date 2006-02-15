Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWBRM6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWBRM6c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWBRMzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27291 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751226AbWBRMzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:06 -0500
Date: Thu, 16 Feb 2006 00:51:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Phillip Susi <psusi@cfl.rr.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060215235144.GD3490@openzaurus.ucw.cz>
References: <43EFD806.3000904@cfl.rr.com> <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!



> > I would disagree.  The only difference between the two is WHERE the 
> > state is maintained - ram vs. disk.  I won't really argue it though, 
> > because it's just semantics -- call it whatever you want.
> 
> It's not just semantics.  There's a real difference between maintaining
> state in the hardware and maintaining it somewhere else.  The biggest
> difference is that if the hardware retains suspend power, it is able to
> detect disconnections.  When the system resumes, it _knows_ whether a
> device was attached the entire time, as opposed to being unplugged and
> replugged (or possibly a different device plugged in!) while the system
> was asleep.  If the hardware is down completely, there is no way of
> telling for certain whether a device attached to some port is the same one
> that was there when the system got suspended.

I have strange system here (intel dual core prototype) that supplies
usb power even while it is "off". I'll need to find a way to fix that.

(Not that it is important to this discussion, just a reminder that strange hw exists)

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

