Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbTCJRVa>; Mon, 10 Mar 2003 12:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbTCJRVa>; Mon, 10 Mar 2003 12:21:30 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:22405 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261369AbTCJRV3>; Mon, 10 Mar 2003 12:21:29 -0500
Date: Mon, 10 Mar 2003 09:31:56 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030310173154.GN2835@ca-server1.us.oracle.com>
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org> <20030308214130.GK2835@ca-server1.us.oracle.com> <20030308215239.A782@infradead.org> <20030308221651.GL2835@ca-server1.us.oracle.com> <20030308222151.A1384@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308222151.A1384@infradead.org>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 10:21:51PM +0000, Christoph Hellwig wrote:
> Damn, to you actually read what I wrote in all previous mails?  THE MAJOR/MINOR
> SPLIT IS GONE FOR BLOCK DEVICES.  There are just ranges, the only difference
> with a bigger dev_t is that the total amount of claimed space can be bigger.

	I understand what you've read.  I've merely been telling you
that there aren't enough ranges for the number of disks we'd like to
handle.  Never mind that a larger dev_t is significantly clearer, or
that a large minor space can help us move to a single disk major if we
want to go there.

> So if you need so damn lot why don't you start auditing the character drivers
> now instead of whining?  

	I've been in contact with Andreas.  I've been trying to get
stuff tested.  I'm ready to commit resources with tons of disks to
test as soon as the code is capable.  I'm not whining, I'm active.
Please, you're a smart guy, let's keep this civil.

Joel

-- 

"Nothing is wrong with California that a rise in the ocean level
 wouldn't cure."
        - Ross MacDonald

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
