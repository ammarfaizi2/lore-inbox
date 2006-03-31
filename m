Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWCaHmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWCaHmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWCaHmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:42:18 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:5783 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751251AbWCaHmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:42:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1BvHK0i8LCC8Hh0FAEAsJZE8nvq9MBVDhrcmI7qnUU0zl+buSJLqvd/GZzi/fvRB/JJdOLOFEaReMqFapW/j0qpzT4tEUGh6uSqXyOeb9+0iAEXz1k0a+IpGpsrOWexeb/DGERklBu9KIfJvKBnutY/k5RUAsEwaTaCTuS3T9pg=  ;
Message-ID: <442C9FFE.6020903@yahoo.com.au>
Date: Fri, 31 Mar 2006 13:20:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, jeff@garzik.org, axboe@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, rpeterso@redhat.com
Subject: Re: [PATCH] splice support #2
References: <20060330100630.GT13476@suse.de>	<20060330120055.GA10402@elte.hu>	<20060330120512.GX13476@suse.de>	<Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>	<442C440B.2090700@garzik.org>	<Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>	<442C7EF5.8090703@yahoo.com.au>	<20060330184325.35e21117.akpm@osdl.org> <20060330185133.176f8210.akpm@osdl.org>
In-Reply-To: <20060330185133.176f8210.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
>>splice() may not be suitable for such filesystems.
> 

Well OK, but my point about making the syscall API use 64-bit
size is not completely invalid. Unless there is some downside
to it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
