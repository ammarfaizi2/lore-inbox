Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVCCC3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVCCC3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVCCC0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:26:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19663 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261415AbVCCCWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:22:05 -0500
Message-ID: <422674A4.9080209@pobox.com>
Date: Wed, 02 Mar 2005 21:21:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com>	<20050302162312.06e22e70.akpm@osdl.org>	<42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
In-Reply-To: <20050302165830.0a74b85c.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 02 Mar 2005 19:29:35 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>If the time between big merges increases, as with this proposal, then 
>>the distance between local dev trees and linux-2.6 increases.
>>
>>With that distance, breakages like the 64-bit resource struct stuff 
>>become more painful.
>>
>>I like my own "ongoing dev tree, ongoing stable tree" proposal a lot 
>>better.  But then, I'm biased :)
> 
> 
> The problem is people don't test until 2.6.whatever-final goes out.
> Nothing will change that.
> 
> And the day Linus releases we always get a pile of "missing MODULE_EXPORT()"
> type bug reports that are one liner fixes.  Those fixes will not be seen by
> users until the next 2.6.x rev comes out and right now that takes months
> which is rediculious for such simple fixes.
> 
> We're talking about a one week "calming" period to collect the brown paper
> bag fixes for a 2.6.${even} release, that's all.

If we want a calming period, we need to do development like 2.4.x is 
done today.  It's sane, understandable and it works.

2.6.x-pre: bugfixes and features
2.6.x-rc: bugfixes only


> All this "I have to hold onto my backlog longer, WAHHH!" arguments are bogus
> IMHO.  We're using a week of quiescence to fix the tree for users so they
> are happy whilst we work on the 2.6.${odd} interesting stuff :-)

If you think it will be only a week, you're deluding yourself.  It will 
stretch out to a month or longer, and the backlog problems will be real.

A calming period is fine.  But this even/odd mess is just silly.

	Jeff


