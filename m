Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUEQW3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUEQW3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUEQWZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:25:13 -0400
Received: from mail.tmr.com ([216.238.38.203]:60676 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263032AbUEQWXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:23:38 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
Date: Mon, 17 May 2004 18:25:51 -0400
Organization: TMR Associates, Inc
Message-ID: <c8bdqv$lib$1@gatekeeper.tmr.com>
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com> <200405151506.20765.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084832415 22091 192.168.12.100 (17 May 2004 22:20:15 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <200405151506.20765.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 15 of May 2004 14:20, Justin Piszcz wrote:
> 
>>The problem is the 2.6.6 kernel muxed my drive and when it fscked upon
>>reboot it deleted /etc/mtab and lilo.conf!
> 
> 
> What fs are you using?
> 
> 
>>Luckily I restored them from a backup and now run 2.6.5 and it is working
>>fine.
>>
>>Linux 2.6.6 is a nightmare.
>>
>>I am looking into the benchmark problem with 2.6.6 now.
>>
>>--- In linux-kernel@yahoogroups.com, "Justin Piszcz" <jpiszcz@h...> wrote:
>>
>>>Now whenever I reboot it says input/output errors when it tries to mount
>>>the drive? I will look into this further.
> 
> 
> This errors are HARMLESS and CAN'T corrupt your data.
> Please see http://bugme.osdl.org/show_bug.cgi?id=2672 for description+fix.

I would think that if the drive didn't properly flush cache on shutdown 
that it might cause corruption. Feel free to tell me no drive would 
bahave like that ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
