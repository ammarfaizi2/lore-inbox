Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTEGMhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 08:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTEGMhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 08:37:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53729 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263140AbTEGMhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 08:37:53 -0400
Date: Wed, 7 May 2003 14:50:27 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: kernel BUG at net/core/skbuff.c:1028!
Message-ID: <20030507125027.GK823@suse.de>
References: <20030507121412.GI823@suse.de> <20030507.042035.13750321.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507.042035.13750321.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 7 May 2003 14:14:12 +0200
> 
>    Booting 2.5-BK on my little router BUG's out before the login is
>    reached. 100% reproduceable. Let me know if you want more detail.
> 
> I forwarded this to Rusty, I think netfilter changes he made
> recently have caused this.

Backing out this puppy:

http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-rusty@rustcorp.com.au|ChangeSet|20030506080426|32903.txt

makes it work. Ruuuuusty?

-- 
Jens Axboe

