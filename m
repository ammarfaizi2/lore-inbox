Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbUBXSZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUBXSYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:24:07 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:25298 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262382AbUBXSXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:23:09 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Feb 2004 18:23:06 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems
Cc: Andy Whitcroft <apw@shadowen.org>
Message-ID: <403B968A.7806.14EEFCEE@localhost>
In-reply-to: <14539106.1077630890@42.150.104.212.access.eclipse.net.uk>
References: <40377251.25966.4C15915@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Ok, the normal step from here is a binary search for the offending patch. 
> You know it works on 2.6.2 and not on 2.6.3.  There should be daily BK 
> snapshots for the period from 2.6.2 to 2.6.3.  See if it broke in the first 
> half/second half and so on.  If you can find the offending patch or day 
> then I am sure someone can find the issue.
>

Hi Andy,

Thanks for reply.

Funnily enough, I looked at this at work today and decided to check 
against 8139too.c from 2.6.2 and 2.6.3 trees.  There was a lot of 
changes, but it appeared only to that file (i.e. nothing referencing 
it) - so I have just built 2.6.3 with the 8139too.c source from 2.6.2 
just to make sure it isn't code elsewhere (i.e. pci stuff?) that is 
causing it.

So far it is running perfectly.  I will wait a while to test, and if 
it doesn't show any problems, we can presume it is the changes that 
caused this problem for me on my system.

Enquiries to the HantsLUG seem to be that no-one else gets this 
problem.

Nick
-- 
"I am not Spock", said Leonard Nimoy.
"And it is highly illogical of humans to assume so."

