Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbSLFBRB>; Thu, 5 Dec 2002 20:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbSLFBRB>; Thu, 5 Dec 2002 20:17:01 -0500
Received: from [195.223.140.107] ([195.223.140.107]:56705 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267487AbSLFBRA>;
	Thu, 5 Dec 2002 20:17:00 -0500
Date: Fri, 6 Dec 2002 02:24:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.20-aa1] Readlatency-2
Message-ID: <20021206012456.GG1567@dualathlon.random>
References: <200212052047.36094.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212052047.36094.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 08:49:10PM +0100, Marc-Christian Petersen wrote:
> Hi all,
> 
> as requested by GrandMasterLee (does he have a realname? ;) here goes 
> readlatency2 for 2.4.20aa1. Apply ontop of it.
> 
> Note: This patch rippes out the elevator-lowlatency hack.

how does it perform compared to elevator-lowlatency? I guess this is a
call for Con to run a pass on it.

Actually I still think the 32M queue on a 32M scsi machine during
contigous writes where the elevator basically doesn't matter is a
""bit"" overkill so I still like elevator-lowlatency somehow. 
elevator-lowlatency could do something smarter than it currently does
though.

Andrea
