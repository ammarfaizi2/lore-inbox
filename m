Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVCCRyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVCCRyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVCCRvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:51:24 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:52621 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262069AbVCCRtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:49:06 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Thu, 3 Mar 2005 09:46:46 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <16934.59991.693197.513163@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.62.0503030941310.29190@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org><42264F6C.8030508@pobox.com><20050302162312.06e22e70.akpm@osdl.org><42265A6F.8030609@pobox.com><20050302165830.0a74b85c.davem@davemloft.net><422674A4.9080209@pobox.com><Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org><42268749.4010504@pobox.com><20050302200214.3e4f0015.davem@davemloft.net><42268F93.6060504@pobox.com><4226969E.5020101@pobox.com><20050302205826.523b9144.davem@davemloft.net>
 <16934.59991.693197.513163@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Neil Brown wrote:

> On Wednesday March 2, davem@davemloft.net wrote:
>> On Wed, 02 Mar 2005 23:46:22 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>>> If Linus/DaveM really don't like -pre/-rc naming, I think 2.6.x.y is
>>> preferable to even/odd.
>>
>> All of these arguments are circular.  If people think that even/odd
>> will devalue odd releases, guess what 2.6.x.y will do?  By that line
>> of reasoning nobody will test 2.6.x just the same as they aren't
>> testing 2.6.x-rc* right now.
>
> I think there is a qualitative difference.
> 2.6.x is the end of a line that 2.6.x-rc* leads up to.  There is a
> clear end.  "I will test when it gets to the end".
>
> 2.6.x.y doesn't.  If the releases are quick (daily if there is
> anything to release) then there is no clear end to the list, just a
> beginning.  There may never be a 2.6.x.1 for some values of x, so
> people won't be able to wait for the .1 or the .2 release.  They will
> have to just take what is available when they want to upgrade.

as one of the users since the mid 2.0 series. I really think this is the 
best approach.

with any 'stable' kernel series I have always had to wait at least a few 
days from the release to allow people to report brown-bag problems, and 
then I've needed to test it on my particular hardware to make sure there 
are no driver gotcha's that happen to bite my configuration, then I can 
deploy (either immediatly if it's a security issue, or after load testing 
if it's not)

the 2.6.odd/even won't change this at all

the 2.6.x.y will leave me needing to do the same thing for each new x, but 
any new .y releases that take place should be able to follow a more rapid 
path as they will probably have _very_ few changes in them (i.e. no driver 
updates that aren't significant bugfixes). and the ability to do more then 
one .y release if nessasary without confusing people is definantly an 
advantage over the odd/even approach

> If we want to stop people from waiting for a final release before they
> test, we need to make sure there isn't a (recognisable in advance)
> final release.

good point

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
