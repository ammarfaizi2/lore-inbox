Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUKXWZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUKXWZD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUKXWZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:25:03 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:62360 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261595AbUKXWY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:24:59 -0500
Message-ID: <41A4F198.70607@blue-labs.org>
Date: Wed, 24 Nov 2004 15:39:52 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2 and x86_64; spontaneous reboots
References: <41A4D5A4.3010605@blue-labs.org> <41A4EDE2.3030309@stud.feec.vutbr.cz>
In-Reply-To: <41A4EDE2.3030309@stud.feec.vutbr.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oddly, yes.  Or almost yes since I haven't measured it exactly.  The 
typical reboot is right around five minutes of uptime.  The three times 
that I did watch /proc/uptime, right around the 2nd column going to 300 
seconds is when it rebooted.

-david

Michal Schmidt wrote:

> David Ford wrote:
>
>> Is anyone else experiencing spontaneous reboots within a few minutes 
>> of bootup?  (If the system survives past the first 10 minutes, it 
>> stays up for a long time, but it reliably does an instant reboot with 
>> no panic or other indication a good 9 out of 10 times.  The system is 
>> purely idle, nothing going on.  memtest86+ runs for hours with no 
>> failures.
>
>
> Do the restarts occur exactly 5 minutes after bootup? That would 
> indicate a problem with jiffies overflow. Probably some buggy driver.
>
> Michal
>
