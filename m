Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVFUWkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVFUWkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVFUWjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:39:05 -0400
Received: from ns1.suse.de ([195.135.220.2]:27852 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262367AbVFUWMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:12:20 -0400
Date: Wed, 22 Jun 2005 00:12:19 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 with dual way dual core ck804 MB
Message-ID: <20050621221218.GE14251@wotan.suse.de>
References: <3174569B9743D511922F00A0C94314230A40468C@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230A40468C@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 02:41:52PM -0700, YhLu wrote:
> andi,
> 
> for the dual way dual core Opteron ck804 MB, the 2.6.12 still has the timing
> problem, I  still need to add one printk in amd_detec_cmp after the
> phys_proc_id is setup.

It works for me on several dual core systems, except on a very big
one that seems to run into a scheduler problem.

Where exactly does yours lock up? 

-Andi

