Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWHQWyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWHQWyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWHQWyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:54:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:39291 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030315AbWHQWyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:54:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MCiQTinqqCwu/aLO4ZGGR3fzdjzMI/276sm2ul9iaViP3EeK6x8E18bWFYmjM1mUEM+l6Q8YmgbYUlWh+xxVttTd9DDbxUWRRBzjmoTzHzJbS/gsxiRWXe7WmlHVNKqBYhPtQ6v8MUTTfZK5DrGM16MvY9/XKLk91FzPQaa7u5E=
Message-ID: <44E4F3AF.2030604@gmail.com>
Date: Thu, 17 Aug 2006 16:54:39 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Nish Aravamudan <nish.aravamudan@gmail.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc4-mm1 Run-time of Locking API testsuite
References: <44E4CC60.3080109@gmail.com> <29495f1d0608171508k2f465419ue5b87ee2847ae3cd@mail.gmail.com>
In-Reply-To: <29495f1d0608171508k2f465419ue5b87ee2847ae3cd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan wrote:
> On 8/17/06, Jim Cromie <jim.cromie@gmail.com> wrote:
>>
>> Note the non-trivial execution time difference:
>>
>> soekris:~/pinlab# egrep -e 'Locking|Good' dmesg-2.6.18-rc4-*
>> dmesg-2.6.18-rc4-mm1-sk:[   16.044699] | Locking API testsuite:
>> dmesg-2.6.18-rc4-mm1-sk:[   96.083576] Good, all 218 testcases passed! |
>> dmesg-2.6.18-rc4-sk:[   18.563808] | Locking API testsuite:
>> dmesg-2.6.18-rc4-sk:[   19.693692] Good, all 218 testcases passed! |
>
> This is more than just a dmesg difference, I assume? As in, you can
> actually tell the difference in time it takes?
>

yes - I can actually see individual cells (the 'ok's) in the table being 
rendered separately.
This is across a serial line, at 115 kbaud, if that matters..

[   22.762505]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  
ok  |  ok  |  ok  |
[   26.589133]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  
ok  |  ok  |  ok  |
[   31.854688]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  
ok  |  ok  |  ok  |

> Thanks,
> Nish
>

