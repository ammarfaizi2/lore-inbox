Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVANSmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVANSmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVANSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:42:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:8127 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261338AbVANSmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:42:12 -0500
Date: Fri, 14 Jan 2005 10:41:46 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@somerset.sps.mot.com>
Cc: linuxppc-embedded@ozlabs.org, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C-MPC: use wait_event_interruptible_timeout between transactions
Message-ID: <20050114184146.GA30093@kroah.com>
References: <Pine.LNX.4.61.0501131816260.27470@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501131816260.27470@blarg.somerset.sps.mot.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 06:21:54PM -0600, Kumar Gala wrote:
> Use wait_event_interruptible_timeout so we dont waste time waiting between 
> transactions like we use to.  Also, we use the adapters timeout so the 
> ioctl cmd I2C_TIMEOUT will now work.

Applied, thanks.

greg k-h
