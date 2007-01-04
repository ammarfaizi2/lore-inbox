Return-Path: <linux-kernel-owner+w=401wt.eu-S932260AbXADExk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbXADExk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 23:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbXADExk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 23:53:40 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:43976 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932260AbXADExj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 23:53:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0TzzswzWkgZ2kJGQE+RVIBgBAJR2hGLegQUGSL7s+3rOrAJPxd5mX6KFNwraebycw2zU4TWRKjhWjGebsr1PNzbdrWbYwG3qrE86DuCo+IlDYCR5kAM9w4WlmyJh5wYuOAle13DHCEWA9W1rGYqtnMs59vda82tc2NSdyebmQzw=  ;
X-YMail-OSG: f2wod1oVM1mL4P1rDCZI.LIzFF8ClspWFM4.igE9gblrXK7Qi000tI7A6qcG4t5A7Uwc7qJOWdQ2ccyiSuQz77X6sJzUp1hxmdqW.yuuMdSwDuiyqe7W.J.WP.PL73N3mI289wagwkxXEJo-
Message-ID: <459C8833.7080500@yahoo.com.au>
Date: Thu, 04 Jan 2007 15:53:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [2.6 patch] the scheduled find_trylock_page() removal
References: <20070102215735.GD20714@stusta.de>
In-Reply-To: <20070102215735.GD20714@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the scheduled find_trylock_page() removal.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I guess I don't have a problem with this going into -mm and making its way
upstream sometime after the next release.

I would normally say it is OK to stay for another year because it is so
unintrusive, but I don't like the fact it doesn't give one an explicit ref
on the page -- it could be misused slightly more easily than find_lock_page
or find_get_page.

Anyone object? Otherwise:

Acked-by: Nick Piggin <npiggin@suse.de>

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
