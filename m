Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWEGNAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWEGNAe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWEGNAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:00:34 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:36187 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932149AbWEGNAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:00:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=enBVcP2jBpr7M5fPqKTEhiRQ/0ZcEoiAbX5WMX42b0J3wXFV5cn/O3CxpyTihf/B+0qeooNQUsngiI9dosNLFyR4yY3xPCPYqAeZDWxuybpbXt9JxPrvSIB0icLqS6KxnodXf6mWdPw9QJFL9citfRuSxHAGAeG+UCyviQE3650=  ;
Message-ID: <445DEF6D.1050902@yahoo.com.au>
Date: Sun, 07 May 2006 23:00:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Mike Galbraith <efault@gmx.de>, Andi Kleen <ak@suse.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com> <200605021859.18948.ak@suse.de> <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer> <445DE925.9010006@yahoo.com.au> <20060507124307.GA20443@flint.arm.linux.org.uk> <445DEE70.10807@yahoo.com.au>
In-Reply-To: <445DEE70.10807@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> I stand by my first reply to your comment WRT the API.

Actually, on rereading, it seems like I was a bit confused about
your proposal. I don't think you specified anyway the units
returned by your new sched_clock(). So it is identical to my
"corrected" interface :\

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
