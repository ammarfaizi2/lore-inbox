Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265225AbUGGQqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUGGQqt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 12:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUGGQqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 12:46:49 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:4926 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265225AbUGGQqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 12:46:42 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6
Date: Wed, 7 Jul 2004 09:44:54 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040705023120.34f7772b.akpm@osdl.org>
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407070944.54281.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 5, 2004 2:31 am, Andrew Morton wrote:
> altix-serial-driver-2.patch
>   Altix serial driver updates
>   altix-serial-driver-fix

Now that John has accepted the LANANA device number request, can you please 
merge this into the BK tree?  It fixes the panics we were seeing with the 
8250 driver and also includes early printk support, which is really nice for 
debugging early boot problems (and, as luck would have it, the ia64 tree has 
one at the moment).

Thanks,
Jesse
