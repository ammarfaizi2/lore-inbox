Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932716AbWCPURs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbWCPURs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWCPURr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:17:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:60550 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932716AbWCPURr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:17:47 -0500
Date: Thu, 16 Mar 2006 21:17:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>, Dave Jones <davej@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Development tree, PLEASE?
In-Reply-To: <1142345347.3027.34.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0603162115150.11776@yvahk01.tjqt.qr>
References: <200603140900_MC3-1-BA9A-44CC@compuserve.com>
 <1142345347.3027.34.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Thu, 2 Feb 2006 17:10:25 -0500, Dave Jones wrote:
>> 
>> > -rw-r--r--    1 davej    davej        1686 Dec 15 23:31 linux-2.6-build-userspace-headers-warning.patch
>> > 
>> > adds a #error to includes if __KERNEL__ isn't being used
>> > (We want people to use the headers from our glibc-kernheaders package,
>> > not from the kernel soucre).
>> 
>>  Red Hat's headers are way out of date.
>> 
>>  Just try compiling this using FC4's latest kernheaders:
>> 
>>         ptrace(PTRACE_SETOPTIONS, child, NULL, PTRACE_O_TRACEFORK);
>> 
>>  PTRACE_O_TRACEFORK is undefined.
>
>
>what is the bugzilla number for this?
>

I created one sometime ago.
Different origin, same problem.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=168045



Jan Engelhardt
-- 
