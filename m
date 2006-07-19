Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWGSO7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWGSO7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 10:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWGSO7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 10:59:35 -0400
Received: from smtp.hickorytech.net ([216.114.192.16]:40580 "EHLO
	avalanche.hickorytech.net") by vger.kernel.org with ESMTP
	id S964858AbWGSO7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 10:59:34 -0400
Message-ID: <44BE48D5.7020107@mnsu.edu>
Date: Wed, 19 Jul 2006 09:59:33 -0500
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Mattias Hedenskog <ml@magog.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS breakage in 2.6.18-rc1
References: <67dc30140607190717r57ed2fe5w719dcca896110d8@mail.gmail.com>
In-Reply-To: <67dc30140607190717r57ed2fe5w719dcca896110d8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did try the xfs_repair 2.8.4 for a volume running on 2.6.17.4 and it 
annihilated the volume.  This volume was not showing signs of crashing.  
So... I guess I would certainly not run xfs_repair unless there is good 
reason.

-- 
Jeffrey Hundstad
PS. ...yes, I had a recent backup ;-)

Mattias Hedenskog wrote:
>> That looks like the death knell of my /, which succumbed on Friday as
>> a result (I believe) of the corruption bug that was in 2.6.16/17.
>> Ironically enough, I also saw the problem during an aptitude upgrade.
>
> Hi all,
>
> I just want to confirm this bug as well and unfortunately it was my
> system disk too who had to take the hit. Im running 2.6.16 and its
> reproducible in 2.6.17 and 2.6.18-rc1 as well. When I tried to repair
> the fs I got the same error as in the previous post, running xfsprogs
> 2.8.4. I haven't had the time to debug this issue further because the
> box is quite critical but I'll keep an eye on the other disks on the
> system still running xfs.
>
> Regards,
> Mattias Hedenskog
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
