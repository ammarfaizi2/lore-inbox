Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265824AbUFOSYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265824AbUFOSYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUFOSW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:22:58 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:22858 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265682AbUFOSWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:22:22 -0400
Date: Tue, 15 Jun 2004 11:32:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       anton@samba.org
Subject: Re: NUMA API observations
Message-Id: <20040615113229.054e02e2.pj@sgi.com>
In-Reply-To: <40CF33D6.80302@colorfullife.com>
References: <40CE824D.9020300@colorfullife.com>
	<20040615110320.GD50463@colin2.muc.de>
	<40CF33D6.80302@colorfullife.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred wrote:
> What's the largest number of cpus that are supported right now? 256?

Kernels for SGI's SN2 boxes are usually compiled with NR_CPUS == 512.
A quick grep of the default config files shows that is the largest.

> First call sysctl or whatever. If it fails, then glibc can assume 256. 

Yes, one _could_ write code such as that.

Spend a little time looking at what glibc has done so far with these
API's.  You will then doubt that the code you recommend would actually
happen consistently.  Be forewarned - if you are on anti-depressant
medications, make sure your prescription is filled first.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
