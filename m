Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUIUSMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUIUSMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUIUSMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:12:51 -0400
Received: from mail.tmr.com ([216.238.38.203]:18960 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267979AbUIUSMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:12:38 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: RARP support disapeard in kernel 2.6.x ?
Date: Tue, 21 Sep 2004 14:13:31 -0400
Organization: TMR Associates, Inc
Message-ID: <cipqh4$g9d$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain><Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain> <Pine.LNX.4.60L.0409211511290.15099@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1095789924 16685 192.168.12.100 (21 Sep 2004 18:05:24 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.60L.0409211511290.15099@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:
> On Tue, 21 Sep 2004, Tigran Aivazian wrote:
> 
>> also, the manpage rarpd(8) says:
>>
>> OBSOLETES
>>       This  rarpd obsoletes kernel rarp daemon present in Linux 
>> kernels up to
>>       2.2 which was controlled by the rarp(8) command.
>>
>> which means the kernel version was removed much earlier.
> 
> 
> # ps aux | grep rarpd
> root      4563  0.0  0.0  1456  332 ?        Ss   15:02   0:00 
> /usr/sbin/rarpd
> # rarp -a
> This kernel does not support RARP.
> 
> Maybe I'm wrong but IIRC rarpd as same as arpd was only neccessary for 
> large RARP table.

Is it possible that you are using an old version of the rarp command 
which is trying to use the kernel RARP rather than using the rarpd?


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
