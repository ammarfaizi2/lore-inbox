Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267349AbUHIX0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267349AbUHIX0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 19:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267348AbUHIX0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 19:26:33 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:57016 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S267349AbUHIXZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 19:25:27 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
Date: Mon, 9 Aug 2004 16:25:01 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <cone.1092092365.461905.29067.502@pc.kolivas.org>
Message-ID: <Pine.LNX.4.60.0408091624310.5013@dlang.diginsite.com>
References: <1092082920.5761.266.camel@cube> <cone.1092092365.461905.29067.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have burned one coaster in the last year with CDrecord (running as root) 
so it's still possible, it's just very rare.

David Lang

On Tue, 10 Aug 2004, Con Kolivas wrote:

> Date: Tue, 10 Aug 2004 08:59:25 +1000
> From: Con Kolivas <kernel@kolivas.org>
> To: Albert Cahalan <albert@users.sourceforge.net>
> Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
>     alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
>     schilling@fokus.fraunhofer.de, axboe@suse.de
> Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
> 
> Albert Cahalan writes:
>
>
>> Joerg:
>>    "WARNING: Cannot do mlockall(2).\n"
>>    "WARNING: This causes a high risk for buffer underruns.\n"
>> Fixed:
>>    "Warning: You don't have permission to lock memory.\n"
>>    "         If the computer is not idle, the CD may be ruined.\n"
>> 
>> Joerg:
>>    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
>>    "WARNING: This causes a high risk for buffer underruns.\n"
>> Fixed:
>>    "Warning: You don't have permission to hog the CPU.\n"
>>    "         If the computer is not idle, the CD may be ruined.\n"
>
> Huh? That can't be right. Every cd burner this side of the 21st century has 
> buffer underrun protection. I've burnt cds _while_ capturing and encoding 
> video using truckloads of cpu and I/O without superuser privileges, had all 
> the cdrecord warnings and didn't have a buffer underrun. Last time I gave 
> superuser privilege to cdrecord it locked my machine - clearly it wasn't 
> rt_task safe.
>
> Con
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
