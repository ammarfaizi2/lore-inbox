Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVFWF61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVFWF61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVFWF61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:58:27 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:9622 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262085AbVFWF6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:58:20 -0400
Message-ID: <42BA4F7E.6000402@namesys.com>
Date: Wed, 22 Jun 2005 22:58:22 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: David Masover <ninja@slaphack.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com> <42B8F4BC.5060100@pobox.com>
In-Reply-To: <42B8F4BC.5060100@pobox.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> We have to maintain said ugly code for decades.

No you don't, I do.

>> filesystem, but if so, it will have to do it much more slowly.  Take the
>> good ideas -- things like plugins -- and make them at least look like
>> incremental updates to the current VFS, and make them available to all
>> filesystems.
>
> So, Reiser4 may eventually take over VFS and be the only Linux
>
> This is how all Linux development is done.
>
> The code evolves over time.
>
> You have just described the path ReiserFS needs to take, in order to
> get this stuff into the kernel, in fact.

You missed his point.  He is saying ext3 code should migrate towards
becoming reiser4 plugins, and reiser4 should be merged now so that the
migration can get started.

I don't really care whether ext3 uses our plugin model.  (If it does,
fine, please credit me for it though, and consider maybe a thank you.  I
am happy to thank the XFS team for the idea of delayed allocation....)

I am entitled to get some advantage from being the first on the block. 
Other fs maintainers don't want me to have that entitlement, so they add
delays to slow us down.  It is odd how Hellwig no longer describes
himself as XFS associated.  Did SGI and him

> There is no entitlement to be merged in the upstream kernel.  

True, but what is interesting is that you don't think the faster
filesystem should be merged, and the others should catch up to it later
if they can, instead you think it should be delayed until all of its
benefits can be transmitted to the other filesystems first so that
everyone can be equal. 


