Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVLPTRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVLPTRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVLPTRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:17:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:40857 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932377AbVLPTRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:17:08 -0500
Date: Fri, 16 Dec 2005 11:16:48 -0800
From: Greg KH <greg@kroah.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.14.3] S3 and USB
Message-ID: <20051216191648.GA4796@kroah.com>
References: <200512161535.13650.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161535.13650.lkml@kcore.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:35:13PM +0100, Jan De Luyck wrote:
> Hello list,
> 
> I'm currently running 2.6.14.3, with S3 suspending, works like a charm.
> The only things i need to disable prior to suspending (just so that I can 
> re-enable them afterwards and have them working is:
> - nsc_ircc (+irda_tools)
> - acerhk 
> 
> USB and the like work without problems. The only problem I have is that if I 
> leave USB 'on' and suspend, any activity to the USB ports causes my laptop to 
> resume but it never resumes correctly. I get a black screen, no entries in 
> the system logs, and I need to hold the power button to power off the 
> machine. Which is very annoying since I tend to plug in my USB mouse before I 
> open the screen.
> 
> Any ideas?

Can you try 2.6.15-rc5?  USB suspend issues are still being worked out
:)

thanks,

greg k-h
