Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVIUAIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVIUAIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVIUAIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:08:52 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:13268 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750755AbVIUAIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:08:51 -0400
Message-ID: <4330A494.7010704@namesys.com>
Date: Tue, 20 Sep 2005 17:08:52 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Jonathan Briggs <jbriggs@esoft.com>, David Masover <ninja@slaphack.com>,
       Pavel Machek <pavel@suse.cz>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <43301FA0.7030906@slaphack.com> <20050920175727.GA17820@thunk.org> <1127240326.10407.22.camel@localhost> <20050920211136.GA6179@thunk.org>
In-Reply-To: <20050920211136.GA6179@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Tue, Sep 20, 2005 at 12:18:46PM -0600, Jonathan Briggs wrote:
>  
>
>>I use Reiser3 and Reiser4 on all my systems and fsck has always worked
>>even if it has been much slower than I would like.  The only problems
>>I've experienced have been on the same level as when an ext2/3
>>filesystem fsck dumps several directories of unlabeled files into lost
>>+found.
>>    
>>
>
>You've obviously never kept several dozen reiserfs filesystem images
>(for use with Xen or User-Mode Linux) on a reiserfs filesystem, and
>then had a hardware failure bad enough that the fsck had to try to
>rebuild the b-tree, I take it?
>  
>
That is fixed in V4.  Until people start to use V4 they should compress
their V3 backup images that they store on V3, or store them on separate
partitions.  I regret that fixing it without a disk format change was
not possible.

Hans
