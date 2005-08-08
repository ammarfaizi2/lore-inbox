Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVHHSdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVHHSdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVHHSdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:33:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932170AbVHHSdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:33:15 -0400
Date: Mon, 8 Aug 2005 11:32:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: greg@kroah.com, linux-kernel@vger.kernel.org, linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
In-Reply-To: <20050808.103304.55507512.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org>
References: <20050808.071211.74753610.davem@davemloft.net>
 <20050808144439.GA6478@kroah.com> <20050808.103304.55507512.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Aug 2005, David S. Miller wrote:
>
> From: Greg KH <greg@kroah.com>
> Date: Mon, 8 Aug 2005 07:44:40 -0700
> 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43c34735524d5b1c9b9e5d63b49dd4c1b394bde4
> > 
> > Although in glancing at it, it might not be the reason...
> 
> No, that isn't it.
> 
> Perhaps it was one of those changes that Linus was doing
> to deal with interrupt setting restoration after resume?

Not likely.

Sounds like fec59a711eef002d4ef9eb8de09dd0a26986eb77, which came in 
through Greg. I'm surprised Greg didn't pick up on that one.

		Linus

