Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267087AbTGOKNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267089AbTGOKNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:13:20 -0400
Received: from mail2.zrz.TU-Berlin.DE ([130.149.4.14]:18606 "EHLO
	mail2.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id S267087AbTGOKNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:13:15 -0400
Message-ID: <3438.194.175.125.228.1058264884.squirrel@mailbox.TU-Berlin.DE>
Date: Tue, 15 Jul 2003 12:28:04 +0200 (CEST)
Subject: Re: Inspiron 8000 makes high pitch noise only with 2.6.0-test1
From: <Daniel.Dorau@alumni.TU-Berlin.DE>
To: <joel.metelius@home.se>
In-Reply-To: <1058258721.2423.2.camel@joelm.2y.net>
References: <4299.194.175.125.228.1058254785.squirrel@mailbox.TU-Berlin.DE>
        <1058258721.2423.2.camel@joelm.2y.net>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,
thank you. I will try this. But doesn't this mean, that it will
consume more power? My belief is that this had worked with
2.4 without that noise.
You said it helped you and others. Has this been discussed on
this or some other mailing list?

Thank you
Daniel

> try turning off
>
> CONFIG_APM_CPU_IDLE
>
> it help me and others, but it had nothing to do with ethernet
> drivers...

> /joel
>
> On Tue, 2003-07-15 at 09:39, Daniel.Dorau@alumni.TU-Berlin.DE wrote:
>> Hi there,
>> yesterday I tried the 2.6.0-test1 kernel for the first time.
>> Installation went flawlessly. However I noticed a high pitch
>> noise from my notebook everytime after the ethernet driver
>> was loaded, no matter which one (eepro100 or e100).
>> It is exactly the noise that my notebook only did with 2.4
>> when _actually_ transmitting data on IRDA.
>> I have no clue whatsoever how the same noise is being triggered
 by
>> the 2.6 kernel. Disabling IRDA (kernel+BIOS) didn't help.
>> Since that noise is somewhat nerving, I would be very happy
>> if someone has an idea how to fix that.
>> This noise does definitely not appear on 2.4 kernel except when
 IRDA
>> is active. On 2.6 I can hear it all the time one the
>> ethernet driver is loaded. It is only interrupted by heavy disc
>> activity.
>> Does anybody has an idea?
>>
>> Please CC me on reply.
>>
>> Thank you
>> Daniel
>>
>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in
 the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>




