Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265831AbUEULey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbUEULey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUEULey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:34:54 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:64479 "EHLO
	texas.encore.com") by vger.kernel.org with ESMTP id S265831AbUEULew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:34:52 -0400
Message-ID: <40ADE959.822F1C23@compro.net>
Date: Fri, 21 May 2004 07:34:49 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
References: <20031003214411.GA25802@rudolph.ccur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty wrote:
> 
> 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
> the registers of an IO device will hang that process uninterruptibly.
> The task runs in an infinite loop in get_user_pages(), invoking
> follow_page() forever.
> 
> Using binary search I discovered that the problem was introduced
> in 2.5.14, specifically in ChangeSetKey
> 
>     zippel@linux-m68k.org|ChangeSet|20020503210330|37095
> 

I know this is an old thread but can anyone tell me if this problem is
resolved in the current 2.6.6 kernel? 

Thanks
Mark
