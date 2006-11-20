Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933817AbWKTAuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933817AbWKTAuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933815AbWKTAuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:50:06 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:25574 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933818AbWKTAuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:50:04 -0500
Message-ID: <4560FB07.2040102@oracle.com>
Date: Sun, 19 Nov 2006 16:47:03 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: xconfig segfault
References: <20061119161231.e509e5bf.randy.dunlap@oracle.com> <20061120004147.GC31879@stusta.de>
In-Reply-To: <20061120004147.GC31879@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Nov 19, 2006 at 04:12:31PM -0800, Randy Dunlap wrote:
>> make xconfig is segfaulting on me in 2.6.19-rc6 and later
>> when I do ^F (find/search).
>> Works fine in 2.6.19-rc5 and earlier.
>>
>> The only message log I get is:
>>
>> qconf[5839]: segfault at 0000000000000008 rip 00000000004289bc rsp 00007fffa08ccf10 error 4
>>
>> I don't see any changes in scripts/kconfig/* in 2.6.19-rc6.
>> Any ideas/suggestions?
> 
> Works fine for me in -rc6.
> 
> Did you upgrade Qt, or could there be any other local change that broke 
> it for you?

Didn't upgrade Qt.  I started out suspecting that it was a local change
that broke it, like a library, but I rebuilt/re-tested 2.6.19-rc[123456]
and rc1..rc5 all work for me, while rc6 segfaults.
And rc6 works for me on an i386/i686 machine, but fails on x86_64.

-- 
~Randy
