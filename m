Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVCaKQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVCaKQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVCaKQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:16:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27297 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261254AbVCaKQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:16:05 -0500
Date: Thu, 31 Mar 2005 02:15:12 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Philip Lawatsch <philip@lawatsch.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
Message-Id: <20050331021512.3b6e85b1.pj@engr.sgi.com>
In-Reply-To: <424BC4D5.90204@lawatsch.at>
References: <3NTHD-8ih-1@gated-at.bofh.it>
	<424B7ECD.6040905@shaw.ca>
	<200503311025.56871.vda@ilport.com.ua>
	<20050331001513.3c4321a7.pj@engr.sgi.com>
	<424BC4D5.90204@lawatsch.at>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your problem is almost certainly in the hardware area (cpu, bios,
memory, power, northbridge, motherboard, cooling or thereabouts).

> Imo memtest86 should not hang onless something screws up [its] memory area

There is nothing else running when memtest runs.  You cannot assume
that your hardware is operating like a sane digital computer when
memtest hangs - the magic of zero's, one's and instruction set
architectures is coming unglued and you are getting a glimpse of the
ugliness that is usually hidden behind the curtain.

Good luck fixing it.

LKML is probably not the place to continue to analyze this, now that
you've recreated it with memtest as well.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
