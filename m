Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262236AbTCHV7T>; Sat, 8 Mar 2003 16:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbTCHV7T>; Sat, 8 Mar 2003 16:59:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56334 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262236AbTCHV7S>;
	Sat, 8 Mar 2003 16:59:18 -0500
Date: Sat, 8 Mar 2003 13:59:44 -0800
From: Greg KH <greg@kroah.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       cherry@osdl.org, rddunlap@osdl.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308215944.GA27363@kroah.com>
References: <20030307151744.73738fdd.rddunlap@osdl.org> <1047080297.10926.180.camel@cherrytest.pdx.osdl.net> <20030307233636.A19260@infradead.org> <20030307154624.12105fa3.akpm@digeo.com> <20030307235454.A19662@infradead.org> <20030308014911.GG2835@ca-server1.us.oracle.com> <20030308015805.GA23591@kroah.com> <20030308021505.GH2835@ca-server1.us.oracle.com> <20030308193137.GC26374@kroah.com> <20030308213932.GJ2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308213932.GJ2835@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 01:39:33PM -0800, Joel Becker wrote:
> On Sat, Mar 08, 2003 at 11:31:37AM -0800, Greg KH wrote:
> > Yes, a ramfs partition is the original target.
> 
> 	Using dd(1) to copy the partition to permanent storage between
> boots?  You do have to solve the permanence problem.  I was thinking
> more along the lines of /dev staying in /, and the userspace system
> updating it at boot.

The permanent storage issue will be handled somehow, the details are
still being worked out :)

thanks,

greg k-h
