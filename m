Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTILHxg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 03:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTILHxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 03:53:36 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4102
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261244AbTILHxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 03:53:35 -0400
Date: Fri, 12 Sep 2003 00:53:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030912075339.GH26618@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <20030909110112.4d634896.skraw@ithnet.com> <16225.13206.910616.386713@notabene.cse.unsw.edu.au> <20030912085435.6a26fec4.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912085435.6a26fec4.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 12 Sep 2003 12:46:46 +1000
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> > > Both are 2.4.22. 192.168.1.1 is the testbox. I saw those with 2GB, but
> > > could fix it through more nfs-daemons and
> > > 
> > >         echo 2097152 >/proc/sys/net/core/rmem_max
> > >         echo 2097152 >/proc/sys/net/core/wmem_max
> > > 
> > > Are these values too small for 6 GB?
> > 
> > No.  The values are proportional to the number of server threads, not
> > the amount of RAM... and they should be un-necessary after 2.4.20
> > anyway as nfsd in the kernel makes the appropriate settings.

So then what do I need to to get those error messages off of my nfs clients?
I have seen this with for a long time through 2.4 and 2.5 (didn't use nfs
with 2.2...).
