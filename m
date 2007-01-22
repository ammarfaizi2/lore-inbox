Return-Path: <linux-kernel-owner+w=401wt.eu-S1751923AbXAVPSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbXAVPSu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXAVPSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:18:49 -0500
Received: from apollo.i-cable.com ([203.83.115.103]:41517 "HELO
	apollo.i-cable.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751926AbXAVPSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:18:49 -0500
Message-ID: <00c201c73e38$95dcba70$28df0f3d@kylecea1512a3f>
From: "kyle" <kylewong@southa.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f> <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan> <005501c73e33$7d9046d0$28df0f3d@kylecea1512a3f> <Pine.LNX.4.64.0701220954540.1711@p34.internal.lan>
Subject: Re: change strip_cache_size freeze the whole raid
Date: Mon, 22 Jan 2007 23:18:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> > Yes, I noticed this bug too, if you change it too many times or change 
>> > it
>> > at the 'wrong' time, it hangs up when you echo numbr >
>> > /proc/stripe_cache_size.
>> >
>> > Basically don't run it more than once and don't run it at the 'wrong' 
>> > time
>> > and it works.  Not sure where the bug lies, but yeah I've seen that on 
>> > 3
>> > different machines!
>> >
>> > Justin.
>> >
>> >
>>
>> I just change it once, then it freeze. It's hard to get the 'right time'
>>
>> Actually I tried it several times before. As I remember there was once it
>> freezed for around 1 or 2 minutes , then back to normal operation. This 
>> is the
>> first time it completely freezed and I waited after around 10 minutes it 
>> still
>> didn't wake up.
>>
>> Kyle
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> What kernel version are you using?  It normally works the first time for
> me, I put it in my startup scripts, as one of the last items.  However, if
> I change it a few times, it will hang and there is no way to reboot except
> via SYSRQ or pressing the reboot button on the machine.
>
> This seems to be true of 2.6.19.1 and 2.6.19.2, I did not try under
> 2.6.20-rc5 because I am tired of hanging my machine :)
>
> Justin.
>

It was 2.6.17.8. Now it's 2.6.7.13 but I won't touch it now! It's around 
15km from me!

