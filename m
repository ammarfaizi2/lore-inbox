Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268895AbTBZSWu>; Wed, 26 Feb 2003 13:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268896AbTBZSWu>; Wed, 26 Feb 2003 13:22:50 -0500
Received: from ns.suse.de ([213.95.15.193]:11791 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268895AbTBZSWu>;
	Wed, 26 Feb 2003 13:22:50 -0500
Date: Wed, 26 Feb 2003 19:33:04 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@suse.de>, lse-tech@projects.sourceforge.net, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [PATCH] New dcache / inode hash tuning patch
Message-ID: <20030226183304.GA30836@wotan.suse.de>
References: <20030226164904.GA21342@wotan.suse.de> <15730000.1046283789@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15730000.1046283789@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 10:23:09AM -0800, Martin J. Bligh wrote:
> It actually seems a fraction slower (see systimes for Kernbench-16,
> for instance).

Can you play a bit with the hash table sizes? Perhaps double the 
dcache hash and half the inode hash ?

I suspect it really just needs a better hash function. I'll cook
something up based on FNV hash.

-Andi
