Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWFIXht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWFIXht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWFIXht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:37:49 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:42967 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030376AbWFIXhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:37:48 -0400
Date: Fri, 9 Jun 2006 17:37:54 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Dave Jones <davej@redhat.com>, Theodore Tso <tytso@mit.edu>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609233754.GO5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Dave Jones <davej@redhat.com>, Theodore Tso <tytso@mit.edu>,
	Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
References: <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609205036.GI7420@redhat.com> <4489E8EF.5020508@garzik.org> <20060609225604.GK5964@schatzie.adilger.int> <4489FFB8.3070203@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489FFB8.3070203@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  19:09 -0400, Jeff Garzik wrote:
> Andreas Dilger wrote:
> >Maybe we should start by deleting ext2 because it is old and obsolete?
> >The reality is that we will never merge the forks back once they are made.
> 
> We _already have_ a relevant example:  ext2 -> ext3.
> 
> A useful fork is in the tree, and you're working on it.

OK, you're right.  We'll continue working on the fork (namely ext3) and
when people who care consider those features stable enough they can port
them to ext2. :-)

Like another person pointed out - there are bugs that are fixed in ext3
that aren't in fixed ext2, and vice versa.  Even though the ext2 code
is basically dead, new bugs are still found in it.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

