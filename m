Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261938AbSI3GwR>; Mon, 30 Sep 2002 02:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261939AbSI3GwR>; Mon, 30 Sep 2002 02:52:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:7893 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261938AbSI3GwQ>; Mon, 30 Sep 2002 02:52:16 -0400
Date: Sun, 29 Sep 2002 23:55:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Manfred Spraul <manfred@colorfullife.com>, lse-tech@lists.sourceforge.net
cc: akpm@digeo.com, tomlins@cam.org,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATH] slab cleanup
Message-ID: <732392454.1033343702@[10.10.2.3]>
In-Reply-To: <3D96F559.2070502@colorfullife.com>
References: <3D96F559.2070502@colorfullife.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could someone test that it works on real SMP?

Tested on 16-way NUMA-Q (shows up races quicker than anything ;-)). 
Boots, compiles the kernel 5 times OK. That's good enough for me. 
No performance regression, in fact was marginally faster (within 
experimental error though).

M.

