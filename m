Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbWGFE6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWGFE6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 00:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWGFE6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 00:58:12 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:47750 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S965165AbWGFE6L (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 00:58:11 -0400
Message-ID: <44AC9865.7040808@namesys.com>
Date: Wed, 05 Jul 2006 21:58:13 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Vladimir V. Saveliev" <vs@namesys.com>, hch@infradead.org,
       Linux-Kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [PATCH 1/2] batch-write.patch
References: <44A42750.5020807@namesys.com>	<20060629185017.8866f95e.akpm@osdl.org>	<1152011576.6454.36.camel@tribesman.namesys.com>	<20060704114836.GA1344@infradead.org>	<44AAA8ED.5030906@namesys.com>	<20060704151832.9f2d87b3.akpm@osdl.org>	<1152117935.6337.48.camel@tribesman.namesys.com> <20060705122615.3a4fca06.akpm@osdl.org>
In-Reply-To: <20060705122615.3a4fca06.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reiser4, FUSE, maybe XFS, and GFS2.  Andreas, your support had
conditions, so I will not characterize for you whether you said Lustre
or you would like it.  Andreas, could you look at the patch and see what
you think?

I think with some confidence that this interface will acquire more users
than those over time.  It really is the right natural interface for most
filesystems that try to carefully optimize write performance.

Andrew Morton wrote:

>
>
>I failed to make a record of which other filesystems will want to use this.
>Do you recall?
>
>
>  
>

