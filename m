Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWFZPSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWFZPSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWFZPSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:18:54 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:2055 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030293AbWFZPSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:18:54 -0400
Date: Mon, 26 Jun 2006 11:18:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Vojtech Pavlik <vojtech@suse.cz>
cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atkbd: restore autorepeat rate after resume
In-Reply-To: <20060626150139.GA24550@suse.cz>
Message-ID: <Pine.LNX.4.44L0.0606261117090.9506-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006, Vojtech Pavlik wrote:

> > It there is no keyboard then you could not change repeat rate before
> > suspending and we don't have anyhting to restore ;)
>  
> What the patch is trying to achieve is that you have the keyboard, set
> the rate, unplug the keyboard, replug the keyboard, get the original
> setting.

Maybe that's what Linus (who originally wrote the patch) was trying to 
achieve.  But my intention was that you could have the keyboard, set the 
rate, then do suspend-to-disk, and afterwards still have the rate that you 
set.

Alan Stern

