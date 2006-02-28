Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWB1LwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWB1LwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWB1LwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:52:23 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:8362 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751607AbWB1LwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:52:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uhU23w20I65Iqm1Z/i9CSmOWr5QydaRZWAHWzdSAkTGClTeyL4f49+OvuUduy9M/9AjkEBb6HJId9kHML1nS+iTIdS2OJnBWmJFxmQdV/9pjiCAdnEC/CtMAq33gaYZuM9bCZXjZg8Wjd1LErNmu3Hfvuq6OFxdWHET2V0Ay9iI=  ;
Message-ID: <44043973.4070202@yahoo.com.au>
Date: Tue, 28 Feb 2006 22:52:19 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joshua Hudson <joshudson@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/27] allow hard links to directories, opt-in for any
 filesystem
References: <bda6d13a0602272204l494e8fe7q67c2509d4e7aa0f7@mail.gmail.com>
In-Reply-To: <bda6d13a0602272204l494e8fe7q67c2509d4e7aa0f7@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson wrote:
> Patch seems to work, might want more testing.
> It probably should not be applied without a discussion, especially
> as no filesystem in kernel tree wants this. I am working on a fs that does.
> 

This is backwards I think. This is not disallowed because there are
no filesystems that want it. Linux doesn't want it so it is disallowed
by the vfs.

You have to put forward a case for why we want it, rather than show us
your filesystem that "wants" it. Right?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
