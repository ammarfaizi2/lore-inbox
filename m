Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUBNSU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 13:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUBNSU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 13:20:57 -0500
Received: from c-24-19-70-33.client.comcast.net ([24.19.70.33]:19076 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S262686AbUBNSU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 13:20:56 -0500
From: Walt H <waltabbyh@comcast.net>
To: miller@techsource.com
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1, etc.
Date: Sat, 14 Feb 2004 10:16:51 -0800
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402141016.51205.waltabbyh@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 06:32:31PM -0500, Timothy Miller wrote:

> For writes, iozone found an upper bound of about 10megs/sec, which is 
> abysmal.  Typically, I'd expect writes to be faster (on a single drive) 
> than reads, because once the write is sent, you can forget about it. 
> You don't have to wait around for something to come back, and that 
> latency for reads can hurt performance.  The OS can also buffer writes 
> and reorder them in order to improve efficiency.

I'm joining this thread rather late, so perhaps I missed something. What 
hardware is the test being ran on? I have an AMD MPX based setup which 
suffers from a chipset bug which effectively limits writes to ~25MB/sec to 
devices connected via the 768 southbridge. Maybe something similar with your 
hardware?

-Walt

