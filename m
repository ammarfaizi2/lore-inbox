Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbRGNO1o>; Sat, 14 Jul 2001 10:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbRGNO1f>; Sat, 14 Jul 2001 10:27:35 -0400
Received: from f245.law9.hotmail.com ([64.4.9.245]:35081 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267643AbRGNO1S>;
	Sat, 14 Jul 2001 10:27:18 -0400
X-Originating-IP: [212.58.172.128]
From: "Jonathan Brugge" <jonathan_brugge@hotmail.com>
To: jdejong@chem.rug.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x swap >= 2*memsize requirement status.
Date: Sat, 14 Jul 2001 16:27:16 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F245FUnIzJFucppbSvA0000b47e@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2001 14:27:16.0283 (UTC) FILETIME=[14CBE8B0:01C10C71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





>From: "J.R. de Jong" <jdejong@chem.rug.nl>
>To: linux-kernel@vger.kernel.org
>Subject: 2.4.x swap >= 2*memsize requirement status.
>Date: Sat, 14 Jul 2001 13:42:46 +0200 (CEST)
>
>Hi all,
>
>I noticed that among fellow linux users there is much confusion about the
>2.4.x swap requirement. Some heard that it is a _requirement_ to have >=
>2*memsize swap or none at all, and others heard that it is advisory in the
>sense that performance/stability wil drop drastically when one does not
>take this advice to heart.
>
>There was a heated debate about the wisdom of the supposed requirement,
>especially since many found it to be a major drawback compared to the
>2.2.x series. However, I think there is a need for clarity on the real
>status of the issue. Which brings me to my question: Can anyone shed some
>light on how 'required' this requirement really is and what one could
>expect to happen when this requirement is not met?
>
>Regards,
>
>Johan de Jong.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

It's not a requirement in the sense that you can't run a system where swap < 
2 * RAM. It's afaik merely a strong suggestion, both for servers and 
workstations. About the difference between 2.4 and 2.2: IIRC Rik van Riel 
(maybe it was Alan Cox or some other person, I'm not sure) wrote some time 
ago to the list, telling that the requirement is not here to stay. Current 
VM is balanced around the 2*RAM-idea, but much work is being done on the 
memory-subsystem, so it shouldn't take too long (as in: before the release 
of 2.6/3.0...) before it's better. For some discussion about this subject, 
take a look at http://gathering.tweakers.net/showtopic.php/172437 or 
http://gathering.tweakers.net/showtopic.php/161652 (both in dutch, My nick 
there is 'odysseus', as you'll see).

---
Disclaimer: all the above was written with experience only from real-life 
situations.
---
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

