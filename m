Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbUJ1Ovd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbUJ1Ovd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbUJ1Osu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:48:50 -0400
Received: from ida.rowland.org ([192.131.102.52]:2820 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261692AbUJ1Oqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:46:55 -0400
Date: Thu, 28 Oct 2004 10:46:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Colin Leroy <colin@colino.net>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.10-rc1 OHCI usb error messages
In-Reply-To: <200410271559.37540.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0410281044070.1088-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, David Brownell wrote:

> So:  since it's not being actively used then, why shouldn't the
> root hub (or any other device) be suspended?  During boot, or at
> any other time.  So long as it works when you plug in a USB device,
> it looks to me like everything is behaving quite reasonably.

The root hub _is_ actively being used during initial probing and 
enumeration, even though no devices may be plugged into it.  Is it 
guaranteed that the root hub isn't suspended until after 
usb_register_root_hub returns?

Alan Stern

