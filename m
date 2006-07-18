Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWGRQX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWGRQX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWGRQX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:23:58 -0400
Received: from dvhart.com ([64.146.134.43]:20917 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751358AbWGRQX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:23:58 -0400
Message-ID: <44BD0B16.6050606@mbligh.org>
Date: Tue, 18 Jul 2006 12:23:50 -0400
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
References: <1153167857.31891.78.camel@lappy>  <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com> <1153224998.2041.15.camel@lappy> <Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com> <44BCE86A.4030602@mbligh.org> <Pine.LNX.4.64.0607180657160.30887@schroedinger.engr.sgi.com> <44BCFA4D.9030300@mbligh.org> <Pine.LNX.4.64.0607180855090.31431@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607180855090.31431@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 18 Jul 2006, Martin J. Bligh wrote:
> 
>>>Maybe we need a NR_UNSTABLE that includes pinned pages?
>>
>>The point of what we decided on Sunday was that we want to count the
>>pages that we KNOW are easy to free. So all of these should be
>>taken out of the count before we take it.
> 
> 
> Unmapped clean pages are easily freeable and do not have these issues.
> Could we just use that for now? Otherwise we have to add counters to the 
> categories that we do not track for now and take them out of the count.

Yup, I think that covers everything.

M.

