Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbVIMPcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVIMPcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVIMPcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:32:36 -0400
Received: from ozlabs.org ([203.10.76.45]:56732 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932677AbVIMPcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:32:35 -0400
Date: Wed, 14 Sep 2005 01:00:10 +1000
From: Anton Blanchard <anton@samba.org>
To: Santiago Leon <santil@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Linda Xie <lxiep@us.ibm.com>
Subject: Re: [RFC] SCSI target for IBM Power5 LPAR
Message-ID: <20050913150009.GG26162@krispykreme>
References: <20050906212801.GB14057@cs.umn.edu> <20050907025932.GU6945@krispykreme> <431EFFE7.6070709@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431EFFE7.6070709@us.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> We use MAX_SECTORS (which is actually 127.5kB) because that's the 
> max_sectors of the loopback device (we have a lot of users that like the 
> flexibility of using loopback with the ibmvscsis driver)... It can be 
> bumped up without any problems because there is code that splits 
> requests if they are larger than the target's max_sectors...
> 
> What would you recommend? 256kB?

~256kB sounds reasonable to me and I notice that other VIO server is
setting it to 256kB :) 

Anton
