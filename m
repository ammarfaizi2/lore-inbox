Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbTCHV3L>; Sat, 8 Mar 2003 16:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbTCHV3L>; Sat, 8 Mar 2003 16:29:11 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:24503 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S262215AbTCHV3K>; Sat, 8 Mar 2003 16:29:10 -0500
Date: Sat, 8 Mar 2003 13:39:33 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       cherry@osdl.org, rddunlap@osdl.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308213932.GJ2835@ca-server1.us.oracle.com>
References: <20030307225710.A18005@infradead.org> <20030307151744.73738fdd.rddunlap@osdl.org> <1047080297.10926.180.camel@cherrytest.pdx.osdl.net> <20030307233636.A19260@infradead.org> <20030307154624.12105fa3.akpm@digeo.com> <20030307235454.A19662@infradead.org> <20030308014911.GG2835@ca-server1.us.oracle.com> <20030308015805.GA23591@kroah.com> <20030308021505.GH2835@ca-server1.us.oracle.com> <20030308193137.GC26374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308193137.GC26374@kroah.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 11:31:37AM -0800, Greg KH wrote:
> Yes, a ramfs partition is the original target.

	Using dd(1) to copy the partition to permanent storage between
boots?  You do have to solve the permanence problem.  I was thinking
more along the lines of /dev staying in /, and the userspace system
updating it at boot.

Joel


-- 

"I don't know anything about music. In my line you don't have
 to."
        - Elvis Presley

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
