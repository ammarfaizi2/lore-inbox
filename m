Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWDZDEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWDZDEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWDZDEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:04:23 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:6837 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751385AbWDZDEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:04:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MKgKS2xWdvr5jZhMbOfxQLOqMd2cvPSOL/3EuXvXC1mn3TedL5WQQW0Bf5b7E9fintrKB5Q8h33U/C1A7X6a1nK6i4RqoEpLILCjYLMgMvHn8z6KXVQTo6F9LQAY+Tef5jxy579vJ5IQWYRXKQhXDhquDYkiYbye347nsco2f1o=  ;
Message-ID: <444EDE24.60605@yahoo.com.au>
Date: Wed, 26 Apr 2006 12:42:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Akinobu Mita <mita@miraclelinux.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, Jens Axboe <axboe@suse.de>,
       Greg KH <greg@kroah.com>
Subject: Re: [patch 1/3] use kref for blk_queue_tag
References: <20060426021059.235216000@localhost.localdomain> <20060426021121.260553000@localhost.localdomain>
In-Reply-To: <20060426021121.260553000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita wrote:

>Use kref for reference counter of blk_queue_tag.
>
>

Indirect function calls can be pretty expensive. I'd rather not
convert performance critical code 'just because'.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
