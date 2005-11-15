Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVKOXqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVKOXqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVKOXqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:46:18 -0500
Received: from smtpout.mac.com ([17.250.248.73]:19652 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965086AbVKOXqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:46:17 -0500
In-Reply-To: <20051115112504.4b645a86.akpm@osdl.org>
References: <20051114150347.1188499e.akpm@osdl.org> <dhowells1132005277@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org> <11717.1132077542@warthog.cambridge.redhat.com> <20051115112504.4b645a86.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2F392031-A796-4343-A85A-F459CAA7E51B@mac.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Date: Tue, 15 Nov 2005 18:45:58 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2005, at 14:25, Andrew Morton wrote:
> Can you remind me again why it requires a blockdev rather than a  
> regular file?
>
> coz people are just going to go and use a loopback mount to get  
> their blockdev, which is a bit sad.

FS-Cache != CacheFS, although the names are a bit confusing.  FS- 
Cache is a generic cache frontend for filesystems, while CacheFS is a  
provider backend that uses a block define internally.  You could  
_also_ use cache files.  If you look at the [0/12] in the list, you  
can see a diagram explaining this all in detail.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


