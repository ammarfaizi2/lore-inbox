Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVLRBRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVLRBRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 20:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVLRBRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 20:17:14 -0500
Received: from lame.durables.org ([64.81.244.120]:59014 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S932333AbVLRBRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 20:17:13 -0500
Subject: Re: [openib-general] Re: [PATCH 13/13] [RFC] ipath Kconfig and
	Makefile
From: Robert Walsh <rjwalsh@pathscale.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217235554.GW23349@stusta.de>
References: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com>
	 <200512161548.lokgvLraSGi0enUH@cisco.com>
	 <20051217215251.GV23349@stusta.de>
	 <1134860084.20575.101.camel@phosphene.durables.org>
	 <20051217235554.GW23349@stusta.de>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 17:17:04 -0800
Message-Id: <1134868624.20575.106.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's a difference between "technically supported by the driver" and 
> "officially supported for our costumers":
> 
> It's fine if you tell the costumers buying your hardware "anything else 
> than 64bit x86_64 kernels is completely unsupported", but for getting 
> your driver included into the kernel it should be 32bit clean [1] and 
> should also work for people using 32bit kernels on an Opteron.

Fair enough - I'll see what I can do.

> What surprises me is that -O3 turned out to be the fastest flag for you.
> 
> Can you send numbers comparing -Os/-O2/-O3 (without -g3, preferable with 
> gcc 4.0) including a description what and how you are measuring?

I'll try get around to this after my vacation and after we've had time
to absorb and address all the other feedback we received.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


