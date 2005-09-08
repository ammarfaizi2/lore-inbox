Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbVIHPVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVIHPVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVIHPVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:21:43 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48740
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932644AbVIHPVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:21:42 -0400
Message-Id: <432073610200007800024489@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:22:41 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmmod notifier chain
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com> <20050908151624.GA11067@infradead.org>
In-Reply-To: <20050908151624.GA11067@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Christoph Hellwig <hch@infradead.org> 08.09.05 17:16:24 >>>
>On Thu, Sep 08, 2005 at 05:03:58PM +0200, Jan Beulich wrote:
>> (Note: Patch also attached because the inline version is certain to
get
>> line wrapped.)
>> 
>> Debugging and maintenance support code occasionally needs to know
not
>> only of module insertions, but also modulke removals. This adds a
>> notifier
>> chain for this purpose.
>
>I don't think this should be exported, _GPL if at all.

That one I can't decide upon; I just took the insertion notifier code
as baseline (which doesn't use _GPL).

>And it certainly shouldn't go in without an actual user.

That's funny - on one hand I'm asked to not submit huge patches (not by
you, but by others), but on the other hand not having the consuming code
in the same patch as the providing one is now deemed to be a problem.

Jan
