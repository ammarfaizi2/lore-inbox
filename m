Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWCLJ0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWCLJ0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 04:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWCLJ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 04:26:25 -0500
Received: from s93.xrea.com ([218.216.67.44]:33691 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S1751195AbWCLJ0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 04:26:24 -0500
Message-Id: <200603120926.AA00811@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Sun, 12 Mar 2006 18:26:17 +0900
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Faster resuming of suspend technology.
In-Reply-To: <200603112246.47596.ncunningham@cyclades.com>
References: <200603112246.47596.ncunningham@cyclades.com>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Yes, right. In your way, there is no thrashing. but it slows booting.
>> I mean, there is a trade-off between booting and after booted.
>> But, what people would want is always both, not either.
>
>I don't understand what you're saying. In particular, I'm not sure why/how you 
>think suspend functionality slows booting or what the tradeoff is "between 
>booting and after booted".
>

Sorry, I used words in not usual way.
I refer "booting" as just resuming. And "after booted" means "after resumed".
In other words, I treat swsusp2 as not note PC's hibernation equivalent,
but just for faster booting technology.
So, What I wanted to say was,

  --- Reading all image in advance ( your way) slows resuming itself.
  --- Reading pages on demand ( e.g. VMware) slows apps after resumed.

Hope my English is understandable one...


>> Especially, your way has problem if you boot( resume ) not from HDD
>> but for example, from NFS server or CD-R or even from Internet.
>
>Resuming from the internet? Scary. Anyway, I hope I'll understand better what 
>you're getting at after your next reply.
>

In Japan, it is not so scary.
We have 100Mbps symmetric FTTH ( optical Fiber To The Home), and
more than 1M homes have it, and price is about 30USD/month.
With this, theoretically you can download 600MB ISO image in one min,
and actually you can download 100MBytes suspend image within 30sec.
So, not click to run (e.g. Java applet) but "click to resume" is not dreaming
but rather feasible. You still think it is scary on this situation?

>> >That said, work has already been done along the lines that you're
>> > describing. You might, for example, look at the OLS papers from last
>> > year. There was a paper there describing work on almost exactly what
>> > you're describing.
>>
>> Could I have URL or title of the paper?
>
>http://www.linuxsymposium.org/2005/. I don't recall the title now, sorry, and 
>can't tell you whether it's in volume 1 or 2 of the proceedings, but I'm sure 
>it will stick out like a sore thumb.
>
>

I checked the URL but could not find the paper,
with keywords of "Cunningham" or "swsusp" or "suspend".
Could you tell me any keyword to find it?

                 --- Okajima, Jun. Tokyo, Japan.

