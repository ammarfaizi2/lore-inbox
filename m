Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWBSQlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWBSQlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWBSQlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:41:49 -0500
Received: from mx1.rowland.org ([192.131.102.7]:38151 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932086AbWBSQls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:41:48 -0500
Date: Sun, 19 Feb 2006 11:41:47 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Phillip Susi <psusi@cfl.rr.com>
cc: Pavel Machek <pavel@suse.cz>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
In-Reply-To: <43F89E57.9010506@cfl.rr.com>
Message-ID: <Pine.LNX.4.44L0.0602191138470.9165-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Feb 2006, Phillip Susi wrote:

> > If it is okay during runtime, it should be okay while suspended. Don't
> > expect users to know about power on USB buses. You may call any system
> > that does not support standby power on USB broken if you wish... 
> > 
> 
> It is only okay to disconnect the drive at any time, running or 
> suspended, after you unmount it.  Fail to do that and you're asking for 
> trouble.

I'm confused.  Weren't you arguing, only a few days ago, that it _should_
be okay to unplug a USB drive while the system is suspended?  After all,
since there's no difference (as far as the kernel can see) between power
loss on the bus and an actual unplug, you can hardly say that one should
be allowed and the other not.

Alan Stern

