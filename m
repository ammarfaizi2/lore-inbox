Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRDFMA5>; Fri, 6 Apr 2001 08:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbRDFMAq>; Fri, 6 Apr 2001 08:00:46 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:10121 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131562AbRDFMAd>; Fri, 6 Apr 2001 08:00:33 -0400
Date: Fri, 6 Apr 2001 17:31:29 +0530
From: Maneesh Soni <smaneesh@in.ibm.com>
To: Tom Leete <tleete@mountain.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Race in fs/proc/generic.c:make_inode_number()
Message-ID: <20010406173129.A14391@in.ibm.com>
Reply-To: smaneesh@in.ibm.com
In-Reply-To: <3ACBFF4C.97AA345F@mountain.net> <3ACC82DA.11D76D45@mountain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3ACC82DA.11D76D45@mountain.net>; from tleete@mountain.net on Thu, Apr 05, 2001 at 10:36:10AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a couple of points:

On Thu, Apr 05, 2001 at 10:36:10AM -0400, Tom Leete wrote:
[...]
> +spinlock_t proc_alloc_map_lock = RW_LOCK_UNLOCKED;
> +
Why not make this static?
Initializer should be SPIN_LOCK_UNLOCKED.

Maneesh Soni
Linux Technology Center,
IBM Bangalore.
