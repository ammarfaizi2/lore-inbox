Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWFIXeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWFIXeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWFIXeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:34:13 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:33449 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932314AbWFIXeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:34:12 -0400
Date: Fri, 9 Jun 2006 17:34:18 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Valdis.Kletnieks@vt.edu
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hch@infradead.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609233418.GN5964@schatzie.adilger.int>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, hch@infradead.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org> <4489B719.2070707@garzik.org> <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com> <4489C3D5.4030905@garzik.org> <m3odx26snk.fsf@bzzz.home.net> <200606092249.k59MnoqD015785@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606092249.k59MnoqD015785@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  18:49 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 09 Jun 2006 23:22:23 +0400, Alex Tomas said:
> > what if proposed patch is safer than an average fix?
> > (given that it's just out of usage unless enabled)
> 
> Those are the *dangerous* patches, because they usually contain bugs
> that weren't tripped over by the 6 people who enabled it while it
> was bouncing around in the -mm tree....

Umm, in case you didn't know, the extent patch which is the primary issue
of discussion here (not the whole 64-bit clean changes though) were run
for MILLIONS of hours under very high IO load on the largest computer
systems in the world for the last year or so.  It is easy to get millions
of hours of usage if there are thousands of servers running this code...

Yes, I have no doubt there will be bugs in the code because the usage
pattern is different for different environments, but we aren't advocating
the inclusion of something major like this that was just written
yesterday in someone's basement.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

