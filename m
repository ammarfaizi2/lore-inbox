Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVKOCcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVKOCcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVKOCcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:32:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932287AbVKOCcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:32:02 -0500
Message-ID: <43794890.7060102@RedHat.com>
Date: Mon, 14 Nov 2005 21:31:44 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FS-Cache: Make NFS use FS-Cache
References: <dhowells1132005277@warthog.cambridge.redhat.com>	<43792217.7030102@RedHat.com> <20051114160730.7d141291.akpm@osdl.org>
In-Reply-To: <20051114160730.7d141291.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steve Dickson <SteveD@redhat.com> wrote:
> 
>>Here is a NFS patch that incorporates the FS-Cache hooks. The
>>caching is done on a per filesystem bases using the new 
>>-o fsc mount flag (i.e mount -o fsc server:/export /mnt/export)
> 
> 
> OK, thanks.   What's the maturity of this patch?
Well its as mature as the can be as this point. The
patch has followed along with David's cachefs patches since
2.6.10 (I believe) and I've take a number of percussions
and did quite bit of testing to ensure there are not any
regressions when the -o fsc mount is not used.

> 
> Are you in a position to publish performance testing results?
Not really... or at least I haven't... maybe David has some...

We've be mostly working on stability and data integrity, in our
copious spare time of course ;-) . And to be quite honest
there are still some stability issue to iron out... But we both felt,
at this point, the best thing to do is get more eyeballs on the
code so we can ensure it moves in the right direction....

steved.

