Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVGLW4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVGLW4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGLW4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:56:51 -0400
Received: from p54A0A036.dip0.t-ipconnect.de ([84.160.160.54]:4862 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262368AbVGLWzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:55:17 -0400
Message-ID: <42D44A45.3040301@trash.net>
Date: Wed, 13 Jul 2005 00:55:01 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: "David S. Miller" <davem@davemloft.net>, dsd@gentoo.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 netfilter: local packets marked as invalid
References: <42CE8E96.1040905@trash.net> <42CEA5E4.40009@gentoo.org> <42D3B063.3000207@trash.net> <20050712.115835.42775885.davem@davemloft.net> <20050712191945.GL9153@shell0.pdx.osdl.net>
In-Reply-To: <20050712191945.GL9153@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * David S. Miller (davem@davemloft.net) wrote:
> 
>>Now the question is what to do about the 2.6.12.x stable
>>tree.  I think we put the offending change there, now we
>>need to revert it there too.  Patrick, could you push this
>>patch to stable@kernel.org so we can resolve that too?
> 
> There's the first fix in the queue, I can either drop that one, or
> patch on top of it.  Dropping what's in the queue[1] is fine for me.
> Below's the backport that Daniel sent over this morning (which applies
> if I drop what's in the queue).  Patrick, does that look ok?  I didn't
> queue this change yet, as I'd prefer it came either from you or with you
> Cc'd so you can ack it.
> 
> [1] http://www.kernel.org/git/?p=linux/kernel/git/chrisw/stable-queue.git;a=blob;h=77843604cf9af8cf5458d97eb56d5346e6d380b3;hb=9aaf5aa7c4e4b8309997d2b433bf7464280799eb;f=queue/netfilter-connection-tracking.patch

Daniel's patch is fine, thanks.

ACKed-by: Patrick McHardy <kaber@trash.net>

Regards
Patrick
