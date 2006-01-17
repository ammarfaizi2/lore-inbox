Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWAQD2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWAQD2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 22:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWAQD2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 22:28:03 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:507 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751330AbWAQD2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 22:28:01 -0500
Message-ID: <43CC643E.3000507@namesys.com>
Date: Mon, 16 Jan 2006 19:27:58 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Nathan Scott <nathans@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linux-xfs@oss.sgi.com, Jeff Mahoney <jeffm@suse.com>,
       Mattia Dongili <malattia@linux.it>
Subject: Re: 2.6.15-mm3 bisection: git-xfs.patch makes reiserfs oops
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060115221458.GA3521@inferi.kami.home> <20060116094817.A8425113@wobbly.melbourne.sgi.com> <43CB6796.4040104@namesys.com> <20060116114805.GB12069@infradead.org>
In-Reply-To: <20060116114805.GB12069@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Mon, Jan 16, 2006 at 01:29:58AM -0800, Hans Reiser wrote:
>  
>
>>Thanks Nathan, Mattia, and Andrew.
>>
>>vs, can you or Jeff look at whether our buffer head inits are
>>sufficiently hardened by next Monday (I know that vs has a lot of mail
>>to catch up to)?  Jeff, if you have time before then, it would be nice
>>if you could handle it, I know hardening V3 is an interest of yours.
>>    
>>
>
>Chris Mason just sent a patch to -fsdevel that initialized bh->b_private
>in reiserfs.  Mattia, I'll bounce you the patch privately, could you try
>to see if it helps?
>
>
>
>  
>
I remember wondering if that fixed it, but was too lazy to go back and
look at whether it was exactly equivalent.;-)

Hans
