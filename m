Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWKHQSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWKHQSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWKHQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:18:12 -0500
Received: from gwmail.nue.novell.com ([195.135.221.19]:20610 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1161032AbWKHQSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:18:11 -0500
Message-Id: <45521193.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 08 Nov 2006 17:19:15 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Martin Lorenz" <martin@lorenz.eu.org>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
References: <20061028200151.GC5619@gimli> <p73hcxklfoy.fsf@verdi.suse.de>
 <20061031160815.GM27390@gimli> <454787AB.76E4.0078.0@novell.com>
 <20061031170320.GA6227@gimli>
In-Reply-To: <20061031170320.GA6227@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Martin Lorenz <martin@lorenz.eu.org> 31.10.06 18:03 >>>
>On Tue, Oct 31, 2006 at 05:28:11PM +0100, Jan Beulich wrote:
>> Can you perhaps get us arch/i386/kernel/{entry,process}.o,
>> .config, and (assuming you can reproduce the original problem)
>> the raw stack dump obtained with a sufficiently high kstack=
>> option?
>
>config and the requested .o files are attached
>...hoping I diden't loose track of my kernel bilds
>stacktrace will follow ASAP

I'm unable to find anything pointing out the reason for this
misbehavior, and I continue to be unable to reproduce it on my
test systems.
Short of somebody else wanting to try to debug this, perhaps
the only way to get more insight is to add some more debug
printing to the unwinder and/or its callers, which I don't have
time to do immediately.

Jan
