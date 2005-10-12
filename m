Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbVJLXY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbVJLXY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbVJLXY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:24:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751486AbVJLXY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:24:28 -0400
Date: Wed, 12 Oct 2005 16:24:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Gabriel A. Devenyi" <ace@staticwave.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] nfsv4 in linux 2.6.13 (-ck7)
Message-ID: <20051012232418.GQ7991@shell0.pdx.osdl.net>
References: <200510121903.04485.ace@staticwave.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510121903.04485.ace@staticwave.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gabriel A. Devenyi (ace@staticwave.ca) wrote:
> This oops seems to occur during heavy i/o load over nfsv4.
> 
>  [kernel] Unable to handle kernel paging request at 0000000000100108 RIP:
>  [kernel] <ffffffff80185e98>{generic_drop_inode+56}

There have been a couple recent reports of this, and a fix is in the works.

See the recent thread here:

http://lkml.org/lkml/2005/9/25/44

>  [kernel] Modules linked in: nvidia
                               ^^^^^^
>  [kernel] Pid: 179, comm: kswapd0 Tainted: P      2.6.13-ck7

Tainted kernel, when sending bug reports please be sure bug happens
w/out tainted kernel.

thanks,
-chris
