Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUEKWDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUEKWDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 18:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUEKWDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 18:03:50 -0400
Received: from mail.tmr.com ([216.238.38.203]:29190 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263679AbUEKWDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 18:03:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Date: Tue, 11 May 2004 18:05:46 -0400
Organization: TMR Associates, Inc
Message-ID: <c7rie7$i4t$1@gatekeeper.tmr.com>
References: <409F4944.4090501@keyaccess.nl>	<200405102125.51947.bzolnier@elka.pw.edu.pl>	<409FF068.30902@keyaccess.nl>	<200405102352.24091.bzolnier@elka.pw.edu.pl>	<20040510215626.6a5552f2.akpm@osdl.org> <20040510221729.3b8e93da.akpm@osdl.org> <40A0B7DA.9090905@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084312839 18589 192.168.12.100 (11 May 2004 22:00:39 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <40A0B7DA.9090905@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Andrew Morton wrote:
> 
>>> It's a bit grubby, but we could easily add a fourth state to
>>> `system_state': split SYSTEM_SHUTDOWN into SYSTEM_REBOOT and 
>>> SYSTEM_HALT. That would be a quite simple change.
>>
>>
>> Like this.  I checked all the SYSTEM_FOO users and none of them seem to
>> care about the shutdown state at present.  Easy.
> 
> 
> Wonderful. Placed the following quick hack on top:
	[snip]
> Seems very wrong there; will likely want to be pushed up a few levels, 
> but... Works For Me.
> 
> Have attached a patch of what I'm currently using against 2.6.6 just in 
> case anyone interested lost track. It's bart+morton+hack.
> 
> Rene.

For which patch I say thank you, it saves a lot of time for people who 
have been following but not applying each level of fix as it came up.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
