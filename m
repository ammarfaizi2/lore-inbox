Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbUKJUVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbUKJUVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbUKJUVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:21:54 -0500
Received: from mail.tmr.com ([216.238.38.203]:49163 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262115AbUKJUVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:21:50 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: insmod module-loading errors, Linux-2.6.9
Date: Wed, 10 Nov 2004 12:38:22 -0500
Organization: TMR Associates, Inc
Message-ID: <4192520E.2080101@tmr.com>
References: <20041108175638.2b3da7b3.colin.lkml@colino.net> <200411090000.iA900Obi004485@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1100117594 19621 192.168.12.100 (10 Nov 2004 20:13:14 GMT)
X-Complaints-To: abuse@tmr.com
Cc: linux-os@analogic.com, Colin Leroy <colin.lkml@colino.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
To: Valdis.Kletnieks@vt.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <200411090000.iA900Obi004485@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 08 Nov 2004 12:52:18 EST, linux-os said:

>>They simply should not have removed the "-f" option of
>>insmod. It's just that simple. This option allowed transient
>>(possible) incompatibilities so that one could be productive
>>and not spend a whole day reinstalling from a distribution
>>CD because the new modules wouldn't work because somebody
>>decided that their special VERMAGIC_STRING was so ")@*&#$%)"
>>important that they preempted my work. Don't get me started....
> 
> 
> Yes, instead you can spend a whole day reinstalling from a
> distribution CD, and then restoring user files from backup,
> because the new module you just 'insmod -f' had a different
> number of parameters to some kernel call, and as a result your
> stack got smashed and took the root filesystem with it....

This is Linux, not MS-DOS, where the system works for the user and you 
shouldn't have to do nonsense like "do you really want to load the 
module?" I agree with Dick, you shouldn't have to recompile the whole 
kernel to fix a trivial change. If you shoot yourself in the foot it's 
your fault, taking away the the gun is the policy of another o/s I won't 
name.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
