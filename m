Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWDGImM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWDGImM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 04:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWDGImM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 04:42:12 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:1404 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932282AbWDGImM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 04:42:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LCM0fZvenThcRdSutdz2dXObMhdli+RZ8BhuSVgBVV3HupWWBBArCZhPPqk01Y/Qw3hk8W/V/yBfpUL2WUcUQobbt7gY631Vf9Wpw98MoEN5EYQ+JqUvfkMNeltUxjyohY/mM7IEbUZvIkoyVrPiqg2G5CH/uB3oHO7E/5eJFwg=  ;
Message-ID: <443605E1.7060203@yahoo.com.au>
Date: Fri, 07 Apr 2006 16:25:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: limit lowmem_reserve
References: <200604021401.13331.kernel@kolivas.org> <200604031248.13532.kernel@kolivas.org> <200604041235.59876.kernel@kolivas.org> <200604061110.35789.kernel@kolivas.org>
In-Reply-To: <200604061110.35789.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> It is possible with a low enough lowmem_reserve ratio to make
> zone_watermark_ok always fail if the lower_zone is small enough.

I don't see how this would happen?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
