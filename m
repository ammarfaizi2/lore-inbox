Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVAMBw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVAMBw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVAMBwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:52:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:60605 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261357AbVALVBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:01:37 -0500
Date: Wed, 12 Jan 2005 13:01:36 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: debugfs directory structure
Message-ID: <20050112210136.GC12319@kroah.com>
References: <52d5watlqs.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d5watlqs.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:50:51PM -0800, Roland Dreier wrote:
> Hi Greg,
> 
> Now that debugfs is merged into Linus's tree, I'm looking at using it
> to replace the IPoIB debugging pseudo-filesystem (ipoib_debugfs).

Great!

> Is
> there any guidance on what the structure of debugfs should look like?
> Right now I'm planning on putting all the debug info files under an
> ipoib/ top level directory.  Does that sound reasonable?

Anarchy rules in debugfs.  Do what you want.  If you stomp over someone
else's stuff, I expect complaints and maybe someone will have to
arbitrate, but odds are that will ever happen is pretty slim.

So yes, ipoib/ in the top level sounds just fine.

thanks,

greg k-h
