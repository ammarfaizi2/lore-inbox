Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbTCHB5j>; Fri, 7 Mar 2003 20:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261992AbTCHB5h>; Fri, 7 Mar 2003 20:57:37 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50956 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261990AbTCHB5c>;
	Fri, 7 Mar 2003 20:57:32 -0500
Date: Fri, 7 Mar 2003 17:58:06 -0800
From: Greg KH <greg@kroah.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       cherry@osdl.org, rddunlap@osdl.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308015805.GA23591@kroah.com>
References: <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307225517.GF2835@ca-server1.us.oracle.com> <20030307225710.A18005@infradead.org> <20030307151744.73738fdd.rddunlap@osdl.org> <1047080297.10926.180.camel@cherrytest.pdx.osdl.net> <20030307233636.A19260@infradead.org> <20030307154624.12105fa3.akpm@digeo.com> <20030307235454.A19662@infradead.org> <20030308014911.GG2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308014911.GG2835@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 05:49:11PM -0800, Joel Becker wrote:
> 
> 	There are a couple issues with this.  I wasn't aware there were
> enough free majors to cover systems with 4000 disks.  Those systems
> exist today.  They're only going to grow.
> 	If you are dynamically building majors, how do you populate
> /dev?

<shameless plug>

http://www.linuxsymposium.org/2003/view_abstract.php?talk=94

greg k-h
