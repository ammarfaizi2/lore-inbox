Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262264AbTCHWLS>; Sat, 8 Mar 2003 17:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262271AbTCHWLS>; Sat, 8 Mar 2003 17:11:18 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:16398 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262264AbTCHWLR>; Sat, 8 Mar 2003 17:11:17 -0500
Date: Sat, 8 Mar 2003 22:21:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Greg KH <greg@kroah.com>, Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
       akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308222151.A1384@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
	Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org> <20030308214130.GK2835@ca-server1.us.oracle.com> <20030308215239.A782@infradead.org> <20030308221651.GL2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030308221651.GL2835@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Sat, Mar 08, 2003 at 02:16:51PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 02:16:51PM -0800, Joel Becker wrote:
> On Sat, Mar 08, 2003 at 09:52:39PM +0000, Christoph Hellwig wrote:
> 	Having more than one major for disks is a hack.  Already.

Damn, to you actually read what I wrote in all previous mails?  THE MAJOR/MINOR
SPLIT IS GONE FOR BLOCK DEVICES.  There are just ranges, the only difference
with a bigger dev_t is that the total amount of claimed space can be bigger.

> 	We've already got systems with 4000 disks attached.  Registered
> with the system, even.  This isn't hiding behind some big array.  They
> are part of the system.  No, it's not on Linux, because Linux can't
> handle it.  But if the system wants to go Linux, Linux has to handle it.
> And 1900 disks wont' cut it *today*.  Never mind 2 years from now.

So if you need so damn lot why don't you start auditing the character drivers
now instead of whining?  

