Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263119AbUJ2Cgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbUJ2Cgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUJ2Cd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:33:57 -0400
Received: from havoc.gtf.org ([69.28.190.101]:43732 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263146AbUJ1XmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:42:04 -0400
Date: Thu, 28 Oct 2004 19:41:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Adrian Bunk <bunk@stusta.de>, acme@conectiva.com.br, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] appletalk: remove an unused function
Message-ID: <20041028234121.GA1539@havoc.gtf.org>
References: <20041028221046.GI3207@stusta.de> <20041028162643.2ee7e30e.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028162643.2ee7e30e.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 04:26:43PM -0700, David S. Miller wrote:
> On Fri, 29 Oct 2004 00:10:46 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > - -static inline void atalk_insert_socket(struct sock *sk)
> > - -{
> > - -	write_lock_bh(&atalk_sockets_lock);
> > - -	__atalk_insert_socket(sk);
> > - -	write_unlock_bh(&atalk_sockets_lock);
> > - -}
> > - -
> 
> This is a patch of a patch, I doubt it will apply cleanly ;-)

Ditto, all the patches sent to me look like this, too.

	Jeff



