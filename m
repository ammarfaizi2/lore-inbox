Return-Path: <linux-kernel-owner+w=401wt.eu-S1750899AbXAIFPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbXAIFPP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 00:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbXAIFPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 00:15:15 -0500
Received: from cantor2.suse.de ([195.135.220.15]:51385 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbXAIFPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 00:15:13 -0500
Date: Mon, 8 Jan 2007 21:14:39 -0800
From: Greg KH <greg@kroah.com>
To: Robert Hirsh <rkhirsh@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-userss@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Keyspan USA-49WLC driver broken in 2.6.18, 4.6.19, and  2.6.20 kernels
Message-ID: <20070109051439.GA3277@kroah.com>
References: <20070109041054.85826.qmail@web50802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109041054.85826.qmail@web50802.mail.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 08:10:54PM -0800, Robert Hirsh wrote:
> Problem: Keyspan USA-49WLC driver broken in 2.6.18,
> 4.6.19, and  2.6.20 kernels

There is a known issue with this if you are using the uhci host
controller.  You are using this host controller, right?

If so, some patches have been posted to the linux-kernel list to fix
this, I just need to clean them up a bit...

Sorry for the delay,

greg k-h
