Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758148AbWLCRcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148AbWLCRcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758162AbWLCRcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:32:23 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:32116 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758148AbWLCRcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:32:22 -0500
Message-ID: <45730A4B.6000702@oracle.com>
Date: Sun, 03 Dec 2006 09:32:59 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: replace "kmalloc+memset" with kzalloc in kernel/
 dir
References: <Pine.LNX.4.64.0612030829400.3793@localhost.localdomain> <20061203092415.f68bfb87.randy.dunlap@oracle.com> <Pine.LNX.4.64.0612031227270.4925@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612031227270.4925@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Sun, 3 Dec 2006, Randy Dunlap wrote:
> 
>> On Sun, 3 Dec 2006 08:31:50 -0500 (EST) Robert P. J. Day wrote:
>>
>>>   Replace kmalloc()+memset() combination with kzalloc().
>>>
>>> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
>>>
>>> ---
>>>
>>>  auditfilter.c |    3 +--
>>>  futex.c       |    4 +---
>>>  kexec.c       |    3 +--
>>>  3 files changed, 3 insertions(+), 7 deletions(-)
>> Please use diffstat -p1 -w70 as indicated in
>> Documentation/SubmittingPatches.
> 
> whoops, sorry.  i hadn't noticed that before.  should i resubmit that
> patch with the correct diffstat formatting?

No.

-- 
~Randy
