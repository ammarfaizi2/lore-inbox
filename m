Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWFISfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWFISfR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWFISfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:35:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21962 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030357AbWFISfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:35:15 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Valdis.Kletnieks@vt.edu, linux-fsdevel@vger.kernel.org,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Mingming Cao <cmm@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060609082013.GP5964@schatzie.adilger.int>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <200606090240.k592enXj009395@turing-police.cc.vt.edu>
	 <20060609082013.GP5964@schatzie.adilger.int>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 19:35:06 +0100
Message-Id: <1149878107.5776.84.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-09 at 02:20 -0600, Andreas Dilger wrote:

> > which implies matching changes to mkfs.ext2 and possibly mount..
> 
> The extents format doesn't need any support from mke2fs.  Currently this
> is activated by a mount option "-o extents", so it won't be used until
> a system administrator actively enables it.

It does need support from e2fsprogs, though; patches have been posed to
ext2-devel and are available on 

	http://www.bullopensource.org/ext4/index.html

though there is work left to do, especially to improve fsck's ability to
repair partially-damaged extent trees.

--Stephen


