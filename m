Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVCCHw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVCCHw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 02:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVCCHw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 02:52:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20611 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261528AbVCCHwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 02:52:39 -0500
Message-ID: <4226C235.1070609@pobox.com>
Date: Thu, 03 Mar 2005 02:52:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com>	<20050302162312.06e22e70.akpm@osdl.org>	<42265A6F.8030609@pobox.com>	<20050302165830.0a74b85c.davem@davemloft.net>	<422674A4.9080209@pobox.com>	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>	<42268749.4010504@pobox.com>	<20050302200214.3e4f0015.davem@davemloft.net>	<42268F93.6060504@pobox.com>	<4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net>
In-Reply-To: <20050302205826.523b9144.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 02 Mar 2005 23:46:22 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>If Linus/DaveM really don't like -pre/-rc naming, I think 2.6.x.y is 
>>preferable to even/odd.
> 
> 
> All of these arguments are circular.  If people think that even/odd
> will devalue odd releases, guess what 2.6.x.y will do?  By that line
> of reasoning nobody will test 2.6.x just the same as they aren't
> testing 2.6.x-rc* right now.

even/odd means that certain releases (even ones) are more magical than 
others.  That's weird, since users aren't used to that sort of thing in 
any other project.

2.6.x.y and 2.6.x-rc [where rc == serious bugfixes only!] are 
understandable to users, because they have seen that sort of thing before.

Users _aren't_ fooled by naming games.  The current 2.6-rc proves that.


> I think they will test the odd releases, because as a real release
> they will get slashdot/lwn.net/etc. announcements.
> 
> That's one of the major things the -rc's don't get.  Maybe it gets
> a reference in lwn.net's weekly kernel article, but mostly kernel
> geeks read those and that's not who we want testing -rc's (such
> geeks already are doing so).

LWN, Slashdot and others will not be fooled though :)  They will note 
that release 2.6.<odd> is not a real release.


> It has to be a "real" release.  That does have an impact.  However,
> I am ambivalent about how to make them real.  Even/odd, 2.6.x.y,
> either is fine with me.

2.6.x.y has a very real engineering benefit:  it becomes a stable 
release branch.  That will encourage even more users to test it, over 
and above a simple release naming change.

Users have been clamoring for a stable release branch in any case, as 
you see from comments about Alan's -ac and an LKML user's -as kernels.

	Jeff


