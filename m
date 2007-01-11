Return-Path: <linux-kernel-owner+w=401wt.eu-S965301AbXAKGoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbXAKGoY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 01:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbXAKGoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 01:44:23 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:21724 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965301AbXAKGoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 01:44:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=i9bZF4LzIY6juFeSjPj9nHaR5plNsoBRrzcbd3kmz2oE21jMUti6sIqEuqTDpAIy9pc7ssV7Rbv2EPQu+45BLqi6ahCMZgGZPC8k67PcVnreeL4GpHsZWU6S7yBYmBDpX09tRq8/7qIPHE7J1dJxUfxA81fYHexCMZPGYHyrpB0=  ;
X-YMail-OSG: oINDlq8VM1nYN6rbdqmRKQeWfYQ.nWOSwCvJ2jPw3pWZSKBW6Nq4P12ZoZ8wy4wjB6rCLHzZ.i7fnuXvpyeSvPvI.XJfXqLzKvdYvFPcHfF3LGch38BcHdpaWJKt5CrQ11U8byavF3gEttQ-
Message-ID: <45A5DCAB.6060900@yahoo.com.au>
Date: Thu, 11 Jan 2007 17:43:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <john@johnmccutchan.com>, rml@novell.com
Subject: Re: 2.6.20-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <20070111051022.GA21724@stusta.de>
In-Reply-To: <20070111051022.GA21724@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
> Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
> Handled-By : John McCutchan <john@johnmccutchan.com>
> Status     : problem is being debugged

I'm not sure that this is actually a regression for 2.6.20-rc.

I'll see if I can cook up something that dumps a bit more info
for us. There must be some peculiar usage pattern and/or filesystem
involved.


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
