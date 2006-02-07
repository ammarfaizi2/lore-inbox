Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWBGD3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWBGD3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWBGD3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:29:08 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:15959 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964947AbWBGD3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:29:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UZL3mL4fAj74UFLrFILj/rA4jYBhMHIOC5FrXbYLSQ5yFkhenFx7KgC2R++IYLCUMJpr2tgZaphNSLiVpBVdVQ50nwGbkMJYBwk1c1x0RXfzE3EJncLycEKc1WVK7z3fmBKeq5/gR3z/rDCE48obt4lEk2DDGBwOPViFf8qTwaY=  ;
Message-ID: <43E813FF.1020504@yahoo.com.au>
Date: Tue, 07 Feb 2006 14:29:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: implement swap prefetching
References: <200602071028.30721.kernel@kolivas.org> <43E80F36.8020209@yahoo.com.au>
In-Reply-To: <43E80F36.8020209@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> It introduces global cacheline bouncing in pagecache allocation and removal

Sorry, not regular pagecache but only swapcache, which already has global
cachelines. Ignore that bit ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
