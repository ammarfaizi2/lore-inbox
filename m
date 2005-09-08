Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbVIHPqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbVIHPqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVIHPqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:46:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48485 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932653AbVIHPqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:46:35 -0400
Date: Thu, 8 Sep 2005 17:46:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, akpm@osdl.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: 2.6.13-git7 strange system freeze
Message-ID: <20050908154620.GB6097@suse.de>
References: <6bffcb0e050908051412e945c9@mail.gmail.com> <6bffcb0e050908083822616326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e050908083822616326@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08 2005, Michal Piotrowski wrote:
> Hi,
> 
> kernel: 2.6.13-mm2
> 
> it happens when I try to download new gnome-2.12 livecd from bittorrent.
> 
> ng02:/home/michal# tail /var/log/kern.log
> [..]
> Sep  8 17:15:39 ng02 kernel: [ 3241.479108] KERNEL: assertion
> ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
> Sep  8 17:15:39 ng02 kernel: [ 3241.479192] KERNEL: assertion
> ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (1127)
> Sep  8 17:15:39 ng02 kernel: [ 3241.479736] KERNEL: assertion
> ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (1127)
> Sep  8 17:15:39 ng02 kernel: [ 3241.831114] KERNEL: assertion
> ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
> Sep  8 17:15:40 ng02 kernel: [ 3242.103942] KERNEL: assertion
> ((int)tp->lost_out >= 0) failed at net/ipv4/tcp_input.c (2148)
> Sep  8 17:15:40 ng02 kernel: [ 3242.103951] Leak l=4294967295 3

Same thing happens in -git from this morning.

-- 
Jens Axboe

