Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWFJHug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWFJHug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 03:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWFJHug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 03:50:36 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:52591 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932439AbWFJHug (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sat, 10 Jun 2006 03:50:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=ZB4XmVng1EgCe8vYDs4OHs7gFmyPQnkGcLe5lam0Fq0xa6AC0N1/bvWKpJn+/n9SvQSYiW8/kD+vPscjwg9MXtBvw7EqqVEkx/FXt7FsPRyz7JhDeLze3WW3C3X2xqiAQ1M6WS0ezomdqDKPFrElgADmllZ2YATI6AQgCHHnRzQ=  ;
Message-ID: <448A79C9.5000500@yahoo.com.au>
Date: Sat, 10 Jun 2006 17:50:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: merging swap prefetching
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't aware there was a push to merge swap prefetching in
2.6.18, until the -mm merge plans post.

I would have expected to see some numbers, however I guess the
"merge unless proven bad" approach for new features works too.

I had a quick look at the code, and I think it still needs
more cleanup and review... it is vaguely difficult to participate
in discussions about these patches because they are often split
over several iterations of versions/fixes, and because it isn't
always clear what they depend on (although in the case of swap
prefetching, that isn't so much of a problem).

And also, there is no linux-mm thread to reply to... could we
have some of the intrusive mm/ patches intended for 2.6.18
posted here before they get merged, or is that too much trouble?

As far as swap prefetching itself goes, I still don't like it
much (same issues still stand), but with some cleaning up the
patch shouldn't be too bad, and I can turn it off... so if people
want it and if numbers show it is working, I wouldn't object.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
