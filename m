Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266818AbUFYRlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266818AbUFYRlx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 13:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUFYRlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 13:41:52 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:26384 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266818AbUFYRl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 13:41:28 -0400
Message-ID: <40DC685E.1020406@techsource.com>
Date: Fri, 25 Jun 2004 14:01:02 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Sean Neakums <sneakums@zork.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <6uhdsz3jud.fsf@zork.zork.net>
In-Reply-To: <6uhdsz3jud.fsf@zork.zork.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sean Neakums wrote:
> I seem to remember somebody, I think maybe Andrew Morton, suggesting
> that a no-journal mode be added to ext3 so that ext2 could be removed.
> I can't find the message in question right now, though.


As an option, that might be nice, but if everyone were to start using 
ext3 even for their non-journalled file systems, the ext2 code would be 
subject to code rot.

