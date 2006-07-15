Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945985AbWGODaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945985AbWGODaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 23:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945990AbWGODaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 23:30:18 -0400
Received: from tomts44.bellnexxia.net ([209.226.175.111]:52398 "EHLO
	tomts44-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1945985AbWGODaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 23:30:17 -0400
Date: Fri, 14 Jul 2006 20:29:07 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: [stable] Linux 2.6.16.25
Message-ID: <20060715032907.GB5944@kroah.com>
References: <20060715025906.GA11167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715025906.GA11167@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 07:59:06PM -0700, Greg KH wrote:
> We (the -stable team) are announcing the release of the 2.6.16.25 kernel.

Oops, please note that we now have some reports that this patch breaks
some versions of HAL.  So if you're relying on HAL, you might not want
to use this fix just yet (please evaluate the risks of doing this on
your own.)

Note that HAL usually does not run on servers, so this should be safe
there.  We'll try to provide a better fix soon...

Sorry about this.

greg k-h
