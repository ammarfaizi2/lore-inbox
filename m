Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWJFBpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWJFBpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 21:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWJFBpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 21:45:30 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:28311 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932561AbWJFBpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 21:45:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QzdkV6jbHYHBwOHz1fsmQOzjAXEouOFsmppWtYuxHeG88gAyw+et7nkGZQ/fnBJe5CHp7aOy0vV7xUwmq5uGbCqTc8zsjySZA59L1uhcRI9lToG+SroBNxfXz8N0zdqQ+tePNtuhmC4BuXFbIfSDw6A1l4sCIrLR+QFDR1ck8nw=  ;
Message-ID: <4525B546.7070305@yahoo.com.au>
Date: Fri, 06 Oct 2006 11:45:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: syphir@syphir.sytes.net
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at fs/inotify.c:181 with linux-2.6.18
References: <452581D7.5020907@syphir.sytes.net>
In-Reply-To: <452581D7.5020907@syphir.sytes.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C.Y.M wrote:
> Since I updated to 2.6.18, I have had the following warnings in my syslog.  Is
> this a known problem? Better yet, is there a solution to this?  I am running on
> a i686 (Athlon XP) 32 bit cpu compiled under gcc-3.4.6.
> 
> 
> Oct  5 08:27:31 sid kernel: BUG: warning at
> fs/inotify.c:181/set_dentry_child_flags()
> Oct  5 08:27:31 sid kernel:  [<c0182a10>] set_dentry_child_flags+0x170/0x190
> Oct  5 08:27:31 sid kernel:  [<c0182adf>] remove_watch_no_event+0x5f/0x70
> Oct  5 08:27:31 sid kernel:  [<c0182b08>] inotify_remove_watch_locked+0x18/0x50
> Oct  5 08:27:31 sid kernel:  [<c01833dc>] inotify_rm_wd+0x6c/0xb0
> Oct  5 08:27:31 sid kernel:  [<c0183e98>] sys_inotify_rm_watch+0x38/0x60
> Oct  5 08:27:31 sid kernel:  [<c0102d8f>] syscall_call+0x7/0xb

I don't think it is a known problem. Is it reproduceable? Any idea what
is making the inotify syscalls?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
