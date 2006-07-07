Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWGGPaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWGGPaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWGGPaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:30:14 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:36709 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751094AbWGGPaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:30:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FI4ILsabaTPlJSq0QHfvJyjMgDQCn4yY64yvyV6vAVO83t/jJvr2E6w0qsfxqZ0pvshcuYVanxtSvcydFvBqScxkUjNjyqVqb5IPhViKFqbVUflRWoDkJLyAs6H51F6wYq1qbE9nutnlZY7KAHTlJN8FuWuW3/h1/oc5HuGxHYw=  ;
Message-ID: <44AE18C0.6030603@yahoo.com.au>
Date: Fri, 07 Jul 2006 18:18:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com> <44AE1690.5070509@yahoo.com.au>
In-Reply-To: <44AE1690.5070509@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> I don't see why test_bit() should be any more "special" than the & operator.

OTOH, I guess test_bit isn't a double underscore variant, and so perhaps
it is. What are the semantics of these things supposed to be? It gets
a bit complex if you're just trying to decide whether need_resched()
needs a barrier() or not :(

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
