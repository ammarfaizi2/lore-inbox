Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVCCBcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVCCBcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCCB3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:29:49 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:37767 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261295AbVCCBXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:23:50 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Date: Wed, 2 Mar 2005 17:23:30 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050302165830.0a74b85c.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0503021717050.27660@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org><42264F6C.8030508@pobox.com><20050302162312.06e22e70.akpm@osdl.org><42265A6F.8030609@pobox.com>
 <20050302165830.0a74b85c.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, David S. Miller wrote:

> On Wed, 02 Mar 2005 19:29:35 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
>
>> If the time between big merges increases, as with this proposal, then
>> the distance between local dev trees and linux-2.6 increases.
>>
>> With that distance, breakages like the 64-bit resource struct stuff
>> become more painful.
>>
>> I like my own "ongoing dev tree, ongoing stable tree" proposal a lot
>> better.  But then, I'm biased :)
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
>
> All this "I have to hold onto my backlog longer, WAHHH!" arguments are bogus
> IMHO.  We're using a week of quiescence to fix the tree for users so they
> are happy whilst we work on the 2.6.${odd} interesting stuff :-)

I understand the desire and benifit to do this sort of fixing, but I 
really don't like extending the odd/even thing to other parts of the 
kernel version numbers

with 2.6.8 a different path was attempted with 2.6.8.1 couldn't we just 
use that numbering scheme (avoiding adding to the numbering confusion 
further) and plan on releasing a 2.6.11.1 next tuesday (or so) with the 
various paper-bag fixes?

If I understand bitkeeper properly Linus wouldn't even need to duplicate 
the patches, he should be able to fork his tree to do the paper-bag fixes 
in one fork while continueing development in the other one and then 
recombining them when either generates a release.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
