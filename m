Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTBCRCb>; Mon, 3 Feb 2003 12:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTBCRCb>; Mon, 3 Feb 2003 12:02:31 -0500
Received: from 115.8.237.216.globalpac.com ([216.237.8.115]:58045 "EHLO
	mail.yessos.com") by vger.kernel.org with ESMTP id <S266840AbTBCRC3>;
	Mon, 3 Feb 2003 12:02:29 -0500
Message-ID: <3E3EA2DC.7000101@tmsusa.com>
Date: Mon, 03 Feb 2003 09:11:56 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01 (NSCD7.01)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not  2.4.x,
References: <5.2.0.9.2.20030203151616.019a5900@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a royal pain - there's been a "linux
ssh hang patch" floating around for ages -

None of the linux vendors seem to want to
fix it, and the openssh maintainers don't
seem to want to fix it - grrr.

BTW we some demoronized ssh 3.4p1 rpms
available for suse and redhat - if it will ease
somebody's pain, feel free to grab them -

Joe


Franz Sirl wrote:

> On 2003-02-02 15:40:33 Bill Davidsen wrote:
>
>> On Wed, 29 Jan 2003, David C Niemi wrote:
>>
>> >
>> > On Tue, 28 Jan 2003, David S. Miller wrote:
>> > >    From: kuznet@ms2.inr.ac.ru
>> > >    Date: Wed, 29 Jan 2003 02:56:41 +0300 (MSK)
>> > >
>> > >    Hey! Interesting thing has just happened, it is the first time 
>> when I
>> > >    found the bug formulating a senstence while writing e-mail not 
>> while
>> > >    peering to code. :-)
>> > >
>> > > Congratulations :-)
>> >
>> > Just to confirm, this fix works for me as well.
>> >
>> > ...
>> > > Indeed, this bug exists in 2.4 as well of course.
>> > >
>> > > This bug is 2.4.3 vintage :-)  It got added as part of initial
>> > > zerocopy merge in fact.
>> >
>> > Odd, then, that it I was unable to reproduce the SSH hangs under 
>> 2.4.18
>> > even once, despite heavily using it for several days under the same
>> > circumstances.  Is there any reason 2.4.x would be better able to 
>> recover?
>> > 2.5.59 with the fix seems to feel a bit less balky than 2.4.18 
>> without the
>> > fix, so it seemed to me that 2.4.18 had some way of recovering at 
>> the cost
>> > of a several second pause in the session.
>>
>> The problem which I have been seeing with some regularity is not the 
>> hang
>> you describe (I see that infrequently) but rather a hang after I exit an
>> ssh connection. I open several dozen windows at a time to a cluster 
>> when I
>> do admin, and when I close almost always at least one doesn't drop 
>> without
>> "~." to help. So far in a hour I haven't seen that.
>
>
> That's some internal problem in OpenSSH, can be seen on Solaris as 
> well. Can be easily reproduced in a ssh session:
>
> nohup sleep 60 &
> logout
>
> The ssh session will terminate only after the sleep exited.
>
> Franz.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


