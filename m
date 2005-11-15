Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVKOI6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVKOI6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVKOI6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:58:10 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:57231 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751392AbVKOI6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:58:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=udOiD/1yVfvXgR1n/l1CRoH6POR5DpuR/0irqHB2x/qyKunQVwA3pBkS2006hUugCyJ6xeUoqN+ZxT83Hc2Kr6/VoBfBHN8jRCnHjFmVmsaiW7aysBnYpKhZxOHRb2pQQTdTG0LsmzwNNCthIC+MebKVJT9wQ9kP2ogB4mgpsNY=  ;
Message-ID: <4379A399.1080407@yahoo.com.au>
Date: Tue, 15 Nov 2005 20:00:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       "Rohit, Seth" <rohit.seth@intel.com>
Subject: Re: [PATCH 03/05] mm rationalize __alloc_pages ALLOC_* flag names
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com> <20051114040353.13951.82602.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051114040353.13951.82602.sendpatchset@jackhammer.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Rationalize mm/page_alloc.c:__alloc_pages() ALLOC flag names.
> 

I don't really see the need for this. The names aren't
clearly better, and the downside is that they move away
from the terminlogy we've been using in the page allocator
for the past few years.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
