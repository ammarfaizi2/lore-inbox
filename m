Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268637AbUHYUct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268637AbUHYUct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268657AbUHYU3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:29:40 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:21697 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268637AbUHYUYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:24:08 -0400
Message-ID: <412CF545.7070601@nortelnetworks.com>
Date: Wed, 25 Aug 2004 16:23:33 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <412CEE38.1080707@namesys.com>
In-Reply-To: <412CEE38.1080707@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Making files into directories caused only two applications out of the
> entire OS to notice the change, and that was because of a bug in what
> error code we returned that we are going to fix.  You think that was a
> disaster; I think it was a triumph.

>  Since we have such a performance lead, Namesys is about to change its
> focus from the storage layer to semantics, look at
> www.namesys.com/whitepaper.html for details.  Semantic enhancements are
> the important stuff, and finally Namesys is where we have all the
> storage layer prerequisites done right, and the real work can begin. 

Just curious about your comments on Jamie Lokier's suggestions for enabling 
files-as-directories semantics without breaking existing apps.

Chris
