Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVAGSrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVAGSrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVAGSrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:47:14 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59885 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261525AbVAGSrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:47:02 -0500
Date: Fri, 7 Jan 2005 10:29:28 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.10] ehci "hc died" on startup (chip bug workaround)
Message-ID: <20050107182928.GA29599@kroah.com>
References: <200501051435.42666.david-b@pacbell.net> <20050107174328.GB28878@kroah.com> <200501071005.43520.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071005.43520.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 10:05:43AM -0800, David Brownell wrote:
> On Friday 07 January 2005 9:43 am, Greg KH wrote:
> > On Wed, Jan 05, 2005 at 02:35:42PM -0800, David Brownell wrote:
> > > We seem to have tracked some annoying board-coupled EHCI startup
> > > problems to a chip bug, with a simple workaround.  Please merge.
> > 
> > Hm, I get a reject from this:
> > ...
> > 
> > What kernel tree is it against?
> 
> Probably my gadget-2.6 tree; here's one that applies against
> current 2.5 BK or your USB integration tree.  Sorry!

Ah, much better, that worked.  Thanks, applied.

greg k-h
