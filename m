Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbTCGWpE>; Fri, 7 Mar 2003 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbTCGWpE>; Fri, 7 Mar 2003 17:45:04 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:3557 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S261829AbTCGWpC>; Fri, 7 Mar 2003 17:45:02 -0500
Date: Fri, 7 Mar 2003 14:55:18 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030307225517.GF2835@ca-server1.us.oracle.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307221217.GB21315@kroah.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 02:12:17PM -0800, Greg KH wrote:
> On Fri, Mar 07, 2003 at 12:30:29PM -0800, Andrew Morton wrote:
> > 32-bit dev_t is an important (and very late!) thing to get into the 2.5
> > stream.  Can we put this ahead of cleanup stuff?
> 
> Can we get people to agree that this will even go into 2.5, due to the
> lateness of it?  I didn't think it was going to happen.

	This is essential.  There are installations using >1000 disks
today (on other OSes, generally).  It can't wait another 2.5 years.

Joel

-- 

Life's Little Instruction Book #237

	"Seek out the good in people."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
