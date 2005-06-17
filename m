Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVFQQku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVFQQku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVFQQku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:40:50 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:64170 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S262015AbVFQQkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:40:46 -0400
Message-ID: <42B2FD00.9060102@nortel.com>
Date: Fri, 17 Jun 2005 10:40:32 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify, improved.
References: <1118855899.3949.21.camel@betsy>  <42B1BC4B.3010804@zabbo.net>	 <1118946334.3949.63.camel@betsy>  <42B227B5.3090509@yahoo.com.au>	 <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy>	 <42B2EE31.9060709@nortel.com> <1119023078.3949.115.camel@betsy>
In-Reply-To: <1119023078.3949.115.camel@betsy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Fri, 2005-06-17 at 09:37 -0600, Chris Friesen wrote:

>>On a newsgroup someone was using inotify, but was asking if there was 
>>any way to also determine which process/user had caused the notification.

> I have been hesitant, though.  I do not want feature creep to be a
> deterrent to acceptance into the Linux kernel.

Absolutely.

> I also think that there could be arguments about security.
> ...can we
> say that read rights are enough for a unprivileged user to know that
> root at pid 820 is writing the file?  I don't know.

I'm sure some reasonable rules could be determined.  Maybe you'd need to 
be the owner of the file to get the extra info, with root able to 
monitor everything.

Maybe there should be a way to load plugins into inotify (something like 
netfilter) so that people load modules to send themselves whatever 
information they want...

Let's get it in first though before thinking too hard about extra stuff.

Chris

