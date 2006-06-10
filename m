Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWFJE3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWFJE3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 00:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWFJE3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 00:29:50 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:29077 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932346AbWFJE3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 00:29:49 -0400
Date: Fri, 9 Jun 2006 22:29:55 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Valdis.Kletnieks@vt.edu, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610042954.GX5964@schatzie.adilger.int>
Mail-Followup-To: Nicholas Miell <nmiell@comcast.net>,
	Valdis.Kletnieks@vt.edu, Alex Tomas <alex@clusterfs.com>,
	Jeff Garzik <jeff@garzik.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org
References: <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net> <44899113.3070509@garzik.org> <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com> <m3odx2b86p.fsf@bzzz.home.net> <200606092252.k59Mqc2Q018613@turing-police.cc.vt.edu> <20060609232108.GM5964@schatzie.adilger.int> <200606100121.k5A1LDjR004186@turing-police.cc.vt.edu> <20060610020900.GU5964@schatzie.adilger.int> <1149907555.2340.7.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149907555.2340.7.camel@entropy>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  19:45 -0700, Nicholas Miell wrote:
> I think changing all of this mess to:
> 
> [root@localhost root]# tune2fs -O extents /dev/whatever
> WARNING: Enabling extents on /dev/whatever will make this filesystem
> unreadable in Linux kernels versions before 2.6.19!
> Are you sure you want to do this? <y/n>
> 
> [root@localhost root]# tune2fs -O ^extents /dev/whatever
> WARNING: Disabling extents on /dev/whatever requires you to run e2fsck
> on this filesystem before it can be used again!
> Are you sure you want to do this? <y/n>
> 
> might assuage many of the fears presented in this thread.

If that were true, then I'd be happy to make this the barrier to entry.
Sadly, I don't think that is the only issue, but I'm happy to be shown
to be wrong.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

