Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWDZCno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWDZCno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWDZCno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:43:44 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:48034 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751352AbWDZCno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:43:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UIyD74VPD848GSm9fLjsd+3IbXmGSRGPTBqltk397oY4Z7srXYTl5nenwvL0Z4mc65vjg9r6EQTp6wBH6X6kauXLJjxYluJuGE3bw/2wbp6JuzaICQvGF72Z2hSvednV+m8aVUmpxHBwZ8LCmGimNcUdQhlRw/2eInrn9y1xdLs=  ;
Message-ID: <444ED9EB.5060205@yahoo.com.au>
Date: Wed, 26 Apr 2006 12:24:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Nigel Cunningham <nigel@suspend2.net>, Pavel Machek <pavel@ucw.cz>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
References: <200604242355.08111.rjw@sisk.pl> <200604252312.26249.rjw@sisk.pl> <200604260718.42681.nigel@suspend2.net> <200604260021.08888.rjw@sisk.pl>
In-Reply-To: <200604260021.08888.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

>This means if we freeze bdevs, we'll be able to save all of the LRU pages,
>except for the pages mapped by the current task, without copying.  I think we
>can try to do this, but we'll need a patch to freeze bdevs for this purpose. ;-)
>

Why not the current task? Does it exit the kernel? Or go through some
get_uesr_pages path?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
