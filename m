Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVCCAfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVCCAfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVCCAcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:32:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24253 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261212AbVCCA3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:29:52 -0500
Message-ID: <42265A6F.8030609@pobox.com>
Date: Wed, 02 Mar 2005 19:29:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org>
In-Reply-To: <20050302162312.06e22e70.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>IMO too confusing.
>>
> 
> 
> 2.6.even: bugfixes only
> 2.6.odd: bugfixes and features.
> 
> That doesn't even confuse me!
> 
> 
>>Developers right now are sitting on big piles, and pushing that back 
>>even further means every odd release means you are creating a 
>>2.4.x/2.5.x backport situation every two releases.
> 
> 
> No, there is no backporting.  If you have a bug, fix it in 2.6.12-pre. 
> There is no need to maintain that bugfix in your 2.6.13-candidate tree.

You are missing where the backporting is.

If the time between big merges increases, as with this proposal, then 
the distance between local dev trees and linux-2.6 increases.

With that distance, breakages like the 64-bit resource struct stuff 
become more painful.

I like my own "ongoing dev tree, ongoing stable tree" proposal a lot 
better.  But then, I'm biased :)

	Jeff


