Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVA2Qxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVA2Qxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVA2Qxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:53:37 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2698 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262937AbVA2Qxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:53:34 -0500
Message-ID: <41FAA446.5090704@nortelnetworks.com>
Date: Fri, 28 Jan 2005 14:44:54 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why does the kernel need a gig of VM?
References: <41FA9B37.1020100@comcast.net>
In-Reply-To: <41FA9B37.1020100@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:

> So what's the layout of that top 1G?  What's it all used for?  Is there
> some obscene restriction of 1G of shared memory or something that gets
> mapped up there?
> 
> How much does it need, and why?  What, if anything, is variable and
> likely to do more than 10 or 15 megs of variation?

I'm guessing the high runners in the variable category are likely to be 
the page cache, all kinds of in-flight IO buffers, and such.

Chris
