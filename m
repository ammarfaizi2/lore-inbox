Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268883AbUIHGyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268883AbUIHGyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268889AbUIHGyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:54:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:49806 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268883AbUIHGyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:54:47 -0400
Date: Wed, 8 Sep 2004 08:54:46 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Is FIOQSIZE compatible? ( was Re: f_ops flag to speed up compatible ioctls in linux kernel)
Message-ID: <20040908065446.GD27886@wotan.suse.de>
References: <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de> <20040907213616.GA3018@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907213616.GA3018@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is FIOQSIZE in arch/x86_64/ia32/ia32_ioctl.c and not in 
> include/linux/compat_ioctl.h ?

Probably historical reasons. The ioctls used to be not merged.
> 
> It is as far as I can see returning simply loff_t which is 64 bit
> on all architectures.

It could be moved into the generic layer, I agree.

-Andi
