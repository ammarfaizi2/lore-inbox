Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVCaSrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVCaSrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVCaSrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:47:45 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:15518 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261620AbVCaSrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:47:41 -0500
Date: Thu, 31 Mar 2005 10:47:06 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: hancockr@shaw.ca, linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
Message-Id: <20050331104706.5eb2b39f.pj@engr.sgi.com>
In-Reply-To: <16971.57746.578503.931803@alkaid.it.uu.se>
References: <3NTHD-8ih-1@gated-at.bofh.it>
	<424B7ECD.6040905@shaw.ca>
	<20050330234133.59fdafdf.pj@engr.sgi.com>
	<16971.57746.578503.931803@alkaid.it.uu.se>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> your memory timings are out of spec.

I don't know what spec applies here, don't really care.
But when I backed off my Memory Timing from 1T to 2T,
my box became stable running this memset() test.

So I am a happy camper, grateful that someone posted
this nice test, and agree with you that it was a memory
timing issue, at least for my system.

Apparently Philip's box has additional "issues".  Whatever.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
