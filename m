Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVCUURs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVCUURs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVCUURs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:17:48 -0500
Received: from ida.rowland.org ([192.131.102.52]:11780 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261170AbVCUURq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:17:46 -0500
Date: Mon, 21 Mar 2005 15:17:45 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Norbert Preining <preining@logic.at>
cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Problems with connect/disconnect cycles
In-Reply-To: <20050321090537.GI14614@gamma.logic.tuwien.ac.at>
Message-ID: <Pine.LNX.4.44L0.0503211513090.2329-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Norbert Preining wrote:

> Dear usb developers, dear Andrew!
> 
> I found that my builtin sd card reader connected via USB port
> experiences several connect/reconnect cycles every time I boot.
> 
> I am using 2.6.11-mm4.
> 
> Here an excerpt from syslog:

> I guess that this should not be the expected behaviour. Now the question
> is wether this is a problem with -mm or with usb stuff?

You mean, a software problem or a hardware problem?

One way to find out is to try going back to an earlier kernel.  When you
do, do these cycles continue to appear?

I'm not aware of any software problem that would show up like this.  
However, if you find that the cycles go away with an older kernel then you 
should build 2.6.11-mm4 with CONFIG_USB_DEBUG turned on.  That's the best 
way to start looking for clues.

Alan Stern

