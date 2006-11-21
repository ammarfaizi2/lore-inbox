Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030714AbWKUEhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030714AbWKUEhp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 23:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030715AbWKUEhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 23:37:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:61919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030714AbWKUEho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 23:37:44 -0500
Date: Mon, 20 Nov 2006 20:29:25 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix "&& 0x03" obvious typo in net1080
Message-ID: <20061121042925.GA8399@kroah.com>
References: <20061119143301.GA2633@1wt.eu> <200611201852.20407.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611201852.20407.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 06:52:19PM -0800, David Brownell wrote:
> On Sunday 19 November 2006 6:33 am, Willy Tarreau wrote:
> > Hi David,
> > 
> > I found this bug while grepping for "&& 0x" in drivers.
> > Care to forward upstream ?
> 
> I thought this already _was_ upstream ... Greg?

It's in my tree, and in the next -mm.  I didn't send it to Linus for
2.6.19, as it's only a debug issue, like you mentioned.

So it's in the pipeline...

thanks,

greg k-h
