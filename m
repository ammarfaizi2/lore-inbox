Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVIASsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVIASsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVIASsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:48:09 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:19793 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030293AbVIASsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:48:07 -0400
X-IronPort-AV: i="3.96,162,1122879600"; 
   d="scan'208"; a="657932457:sNHT32257158"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-cluster] Re: GFS, what's remaining
Date: Thu, 1 Sep 2005 11:47:54 -0700
Message-ID: <75D9B5F4E50C8B4BB27622BD06C2B82B7B8E04@xmb-sjc-235.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-cluster] Re: GFS, what's remaining
Thread-Index: AcWvHoEdtNNM031FTBqDl5czu1K2UAABCqmw
From: "Hua Zhong \(hzhong\)" <hzhong@cisco.com>
To: "linux clustering" <linux-cluster@redhat.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Sep 2005 18:47:55.0241 (UTC) FILETIME=[AA1A0590:01C5AF25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just started looking at gfs. To understand it you'd need to look at it
from the entire cluster solution point of view.

This is a good document from David. It's not about GFS in particular but
about the architecture of the cluster.

http://people.redhat.com/~teigland/sca.pdf 

Hua

> -----Original Message-----
> From: linux-cluster-bounces@redhat.com 
> [mailto:linux-cluster-bounces@redhat.com] On Behalf Of 
> Christoph Hellwig
> Sent: Thursday, September 01, 2005 10:56 AM
> To: Alan Cox
> Cc: Christoph Hellwig; Andrew Morton; 
> linux-fsdevel@vger.kernel.org; linux-cluster@redhat.com; 
> linux-kernel@vger.kernel.org
> Subject: [Linux-cluster] Re: GFS, what's remaining
> 
> On Thu, Sep 01, 2005 at 04:28:30PM +0100, Alan Cox wrote:
> > > That's GFS.  The submission is about a GFS2 that's 
> on-disk incompatible
> > > to GFS.
> > 
> > Just like say reiserfs3 and reiserfs4 or ext and ext2 or 
> ext2 and ext3
> > then. I think the main point still stands - we have always taken
> > multiple file systems on board and we have benefitted 
> enormously from
> > having the competition between them instead of a dictat 
> from the kernel
> > kremlin that 'foofs is the one true way'
> 
> I didn't say anything agains a particular fs, just that your previous
> arguments where utter nonsense.  In fact I think having two 
> or more cluster
> filesystems in the tree is a good thing.  Whether the gfs2 
> code is mergeable
> is a completely different question, and it seems at least debatable to
> submit a filesystem for inclusion that's still pretty new.
> 
> While we're at it I can't find anything describing what gfs2 is about,
> what is lacking in gfs, what structual changes did you make, etc..
> 
> p.s. why is gfs2 in fs/gfs in the kernel tree?
> 
> --
> Linux-cluster mailing list
> Linux-cluster@redhat.com
> http://www.redhat.com/mailman/listinfo/linux-cluster
