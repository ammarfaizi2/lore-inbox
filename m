Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262049AbSJNS3Q>; Mon, 14 Oct 2002 14:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbSJNS3Q>; Mon, 14 Oct 2002 14:29:16 -0400
Received: from homer.mpdft.gov.br ([200.184.102.212]:47365 "EHLO
	flanders.mpdft.gov.br") by vger.kernel.org with ESMTP
	id <S262049AbSJNS3P>; Mon, 14 Oct 2002 14:29:15 -0400
Message-ID: <F993807AD0E4D511AF72009027B2268B0147DC1C@saoluis.mpdft>
From: Robson Paniago de Miranda <Robsonm@mpdft.gov.br>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 0/5] ACL support for ext2/3 
Date: Mon, 14 Oct 2002 16:34:56 -0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Andreas Gruenbacher released version 0.8.51 solving a bug in 
which a user could receive the "others" permission if the group 
permissions are zero. There is still time to integrate these changes?

Robson


> The following patch set adds ACL support to the ext2/3 filesystem.  It
> is a port of the 0.8.50 patches from Andreas Gruenbacher.  It requires
> the Extended Attribute patches which I had sent earlier as a
> pre-requisite, and represents the 2nd of 3 sets of patches from the
> acl.bestbits.at code.  (The first set was the EA patches; this is the
> second set of patches; and the third set of patches adds ACL support to
> NFS, so that the NFS server respects the ACL set on the filesystem.)
> 
> Some of these patches in this set are shared in common with the XFS
> filesystem, and are needed for ACL support in XFS as well.  These
> patches are versus 2.5.40, and still reflect the original design
> decision of allowing ext2 and ext3 ACL support to be available as
> separate standalone modules.  (See the discussion of the EA patches
> about whether or not this makes sense.)
> 
> Please comment/bleed on these patches.
