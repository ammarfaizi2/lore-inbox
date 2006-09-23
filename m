Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWIWUi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWIWUi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWIWUi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:38:26 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:27885 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S964837AbWIWUi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:38:26 -0400
Date: Sat, 23 Sep 2006 21:38:23 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm2: __fscache_register_netfs compile error
In-Reply-To: <13720.1158921566@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0609232122074.5644@sheep.housecafe.de>
References: <Pine.LNX.4.64.0609171022160.27242@sheep.housecafe.de> 
 <20060912000618.a2e2afc0.akpm@osdl.org>  <13720.1158921566@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Fri, 22 Sep 2006, David Howells wrote:
> --->	CONFIG_FSCACHE=m
> 	# CONFIG_CACHEFILES is not set
> --->	CONFIG_NFS_FS=y
[...]
> I'm not sure what I can do about that.  NFS_FS doesn't depend on FSCACHE, and
> so isn't forced to become a module when FSCACHE is.  The dependency is through
> one of NFS's configuation options.

I'll try to build with different settings (CONFIG_FSCACHE=y and will 
look at the Kconfig for this one again, only my (faster) build-machine 
is offline right now...

Thanks,
Christian.
-- 
BOFH excuse #378:

Operators killed by year 2000 bug bite.
