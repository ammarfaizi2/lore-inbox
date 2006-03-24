Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWCXWQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWCXWQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWCXWQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:16:59 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:53130 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751475AbWCXWQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:16:58 -0500
Date: Fri, 24 Mar 2006 15:16:56 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Valerie Henson <val_henson@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
       arjan@linux.intel.com, zach.brown@oracle.com
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060324221656.GW14852@schatzie.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Valerie Henson <val_henson@linux.intel.com>,
	Andrew Morton <akpm@osdl.org>, pbadari@gmail.com,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net,
	arjan@linux.intel.com, zach.brown@oracle.com
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com> <20060322224844.GU12571@goober> <20060322175503.3b678ab5.akpm@osdl.org> <20060324143239.GB14508@goober> <20060324192802.GK14852@schatzie.adilger.int> <20060324200131.GE18020@thunk.org> <20060324210033.GQ14852@schatzie.adilger.int> <20060324213905.GG18020@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324213905.GG18020@thunk.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006  16:39 -0500, Theodore Ts'o wrote:
> On Fri, Mar 24, 2006 at 02:00:33PM -0700, Andreas Dilger wrote:
> > Are you saying to make a filesystem test harness in userspace, or to
> > add hooks into the kernel to trigger specific cases in the running
> > kernel?
> 
> The former: a filesystem test harness in userspace, possibly with some
> kernel code changes to make it easier to integrate it with the
> userspace test harness.  It's very similar to what the Netfilter folks
> did, and it has the advantage that we can do testing much more
> quickly, especially in cases where we want to simulate crashes at
> certain specific test points to make sure the journal recovery happens
> correctly.

I seem to recall that the Stanford Metacompilation group (Dawson Engler)
already wrote such a tool.  Not sure what sort of access there is for the
tool, whether public funding would grant access to the public, or if they
are at least willing to make an online interface available (the group has
spun out into "Coverity", and it seems unlikely it will be completely OSS).

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

