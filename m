Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265300AbRGEOy5>; Thu, 5 Jul 2001 10:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265310AbRGEOys>; Thu, 5 Jul 2001 10:54:48 -0400
Received: from ns.guardiandigital.com ([209.11.107.5]:39175 "HELO
	juggernaut.dmz.guardiandigital.com") by vger.kernel.org with SMTP
	id <S265300AbRGEOyi>; Thu, 5 Jul 2001 10:54:38 -0400
Message-ID: <3B447FAD.1E4724C9@guardiandigital.com>
Date: Thu, 05 Jul 2001 10:54:37 -0400
From: Nick DeClario <nick@guardiandigital.com>
Reply-To: nick@guardiandigital.com
Organization: Guardian Digital, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zaitsev <pz@spylog.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: <1011478953412.20010705152412@spylog.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just out of curiousity what are the advantages to having a RAID1 swap
partition?  Setting the swap priority to 0 (pri=0) in the fstab of all
the swap partitions on your system should have the same effect as doing
it with RAID but without the overhead, right?  RAID1 would also mirror
your swap.  Why would you want that? 

Regards,
	-Nick

Peter Zaitsev wrote:
> 
> Hello linux-kernel,
> 
>   Does anyone have information on this subject ?  I have the constant
>   failures with system swapping on RAID1, I just wanted to be shure
>   this may be the problem or not.   It works without any problems with
>   2.2 kernel.
> 
> --
> Best regards,
>  Peter                          mailto:pz@spylog.ru
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Nicholas DeClario
Systems Engineer                            Guardian Digital, Inc.
(201) 934-9230                Pioneering.  Open Source.  Security.
nick@guardiandigital.com            http://www.guardiandigital.com
