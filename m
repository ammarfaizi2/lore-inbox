Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUAGRdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUAGRdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:33:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:61644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266241AbUAGRdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:33:52 -0500
Date: Wed, 7 Jan 2004 09:33:45 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: "Miscellaneous" bus for the driver model?
Message-ID: <20040107173345.GD31177@kroah.com>
References: <Pine.LNX.4.44L0.0401071054220.850-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0401071054220.850-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:00:16AM -0500, Alan Stern wrote:
> Would it make sense for the driver model core to add a "miscellaneous" or 
> "other" bus, intended for devices or drivers that are one-of-a-kind or 
> otherwise non-standard?  Kind of similar to the platform bus but meant 
> for new things, not part of a legacy or other system/architecture-specific 
> base?

That's what the "legacy" bus is for.  There's a patch floating around
that renames that bus to "platform" to remove any connotation that
"legacy" might occur.

Hope this helps,

greg k-h
