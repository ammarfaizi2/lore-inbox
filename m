Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVGMASX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVGMASX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGMASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:18:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262409AbVGMAQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:16:21 -0400
Date: Tue, 12 Jul 2005 17:16:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Chris Wright <chrisw@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       dsd@gentoo.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 netfilter: local packets marked as invalid
Message-ID: <20050713001608.GE19052@shell0.pdx.osdl.net>
References: <42CE8E96.1040905@trash.net> <42CEA5E4.40009@gentoo.org> <42D3B063.3000207@trash.net> <20050712.115835.42775885.davem@davemloft.net> <20050712191945.GL9153@shell0.pdx.osdl.net> <42D44A45.3040301@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D44A45.3040301@trash.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick McHardy (kaber@trash.net) wrote:
> Chris Wright wrote:
> >* David S. Miller (davem@davemloft.net) wrote:
> >
> >>Now the question is what to do about the 2.6.12.x stable
> >>tree.  I think we put the offending change there, now we
> >>need to revert it there too.  Patrick, could you push this
> >>patch to stable@kernel.org so we can resolve that too?
> >
> >There's the first fix in the queue, I can either drop that one, or
> >patch on top of it.  Dropping what's in the queue[1] is fine for me.
> >Below's the backport that Daniel sent over this morning (which applies
> >if I drop what's in the queue).  Patrick, does that look ok?  I didn't
> >queue this change yet, as I'd prefer it came either from you or with you
> >Cc'd so you can ack it.
> >
> >[1] 
> >http://www.kernel.org/git/?p=linux/kernel/git/chrisw/stable-queue.git;a=blob;h=77843604cf9af8cf5458d97eb56d5346e6d380b3;hb=9aaf5aa7c4e4b8309997d2b433bf7464280799eb;f=queue/netfilter-connection-tracking.patch
> 
> Daniel's patch is fine, thanks.
> 
> ACKed-by: Patrick McHardy <kaber@trash.net>

Great, thanks.
-chris
