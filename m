Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWE3TMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWE3TMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWE3TMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:12:41 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:46301 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932437AbWE3TMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:12:40 -0400
Date: Tue, 30 May 2006 13:12:41 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: sho@tnes.nec.co.jp
Cc: cmm@us.ibm.com, jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, tytso@mit.edu, sct@redhat.com
Subject: Re: [UPDATE][12/24]ext3 enlarge blocksize
Message-ID: <20060530191241.GJ5964@schatzie.adilger.int>
Mail-Followup-To: sho@tnes.nec.co.jp, cmm@us.ibm.com,
	jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, tytso@mit.edu, sct@redhat.com
References: <20060530212434sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530212434sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2006  21:24 +0900, sho@tnes.nec.co.jp wrote:
> On May 26, 2006, Andreas wrote:
> > At least part of this patch can be included into the patch series that
> > Mingming has posted to allow larger block sizes on architectures that
> > support it.  This doesn't need a separate COMPAT flag itself, since
> > older kernels will already refuse to mount a filesystem with 
> > large blocks.
> 
> Do you mention block size?

Yes, it just seemed confusing to be including these two items in the
same patch.  I was trying to indicate that the 64k block support should
be submitted to Mingming as a standalone patch atop her patch series,
which is the one that will be submitted for kernel inclusion.

> I don't use the COMPAT flag for large block size, but for >2G blocks.

Agreed.  However, there will be a different COMPAT flag for large
filesystems introduced as part of the other 48-bit ext3 changes.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

