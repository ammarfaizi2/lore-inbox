Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265081AbUEYToj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUEYToj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUEYToj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:44:39 -0400
Received: from mail.kssb.net ([198.248.45.1]:30311 "EHLO california.campus")
	by vger.kernel.org with ESMTP id S265082AbUEYToX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:44:23 -0400
Message-ID: <40B3A219.6090202@kssb.net>
Date: Tue, 25 May 2004 14:44:25 -0500
From: Bradley Hook <bhook@kssb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085468812.2783.7.camel@laptop.fenrus.com> <B58A76BA-AE60-11D8-BD27-000A95CC3A8A@mesatop.com> <40B36E0B.3090605@kssb.net> <40B395A0.2040002@timesys.com>
In-Reply-To: <40B395A0.2040002@timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2004 19:44:22.0238 (UTC) FILETIME=[AD3CBFE0:01C44290]
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

La Monte H.P. Yarroll wrote:
> 
>>
>> Why not design the DCO so that it assumes an author accepts the most 
>> recent published version unless specified. You could then shorten the 
>> line to:
>>
>> DCO-Sign-Off: Random J Developer <random@developer.org>
> 
> 
> If I'm looking at a 15 year old document where do I go to find out what
> "most recent published version" meant at that time?  This assumes we're
> talking about a document that has a clear timestamp.  If we care about
> the version number at all, it should be in every signoff line.
> 

It's similar to when an author licenses something under GPL with:

"either version 2 of the License, or (at your option) any later version."

By doing this, you are trusting that whoever is in charge of releasing a 
new revision of the DCO is not going to put something in there that 
would alter the base meaning or intent of the DCO; Only corrections or 
additions to allow for special cases. Notice that the DCO reads as 3 
options ORed together, which means only 1 has to be true. If that design 
were maintained, then any additions/corrections should not have an 
affect on an old sign-off.

If anyone is concerned about this, then they should include a version 
number in the sign off. But put the version after the line identifier 
(Signed-off-by:), and only if you - the person signing off - are going 
to care about it. But if you're that paranoid, you should probably also 
be explicitly stating which option you are signing off on, and "what 
DCO" you are using...

DCO 1.0(a) as submitted by Linus Torvalds on the LKML on 5/23/04: Random 
J Developer <random@developer.org>

Come on now, get serious.

~Brad
