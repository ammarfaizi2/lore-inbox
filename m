Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbUKOLzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUKOLzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbUKOLzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:55:07 -0500
Received: from isma.kharkov.ua ([217.144.73.247]:19910 "EHLO
	www.isma.kharkov.ua") by vger.kernel.org with ESMTP id S261572AbUKOLyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:54:51 -0500
Message-ID: <41989904.7090209@isma.kharkov.ua>
Date: Mon, 15 Nov 2004 13:54:44 +0200
From: zergio <zergio@isma.kharkov.ua>
Organization: =?UTF-8?B?0JjQodCc0JA=?=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru-RU; rv:1.7.4) Gecko/20040926
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27 suddenly hangs
References: <419886CE.2030304@isma.kharkov.ua> <41988EEC.3040708@corscience.de>
In-Reply-To: <41988EEC.3040708@corscience.de>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Braunschmidt wrote:

> I have a similar problem at the moment, i have setup my box with 
> gentoo and now i get hardlocks from time to time (time < 1.5 days), 
> happens with and without x, kernel 2.4.27 untainted, with apic on and 
> off, acpi on and off, apm on and off...
>
> @zergio: Can you tell me if it only happened with 2.4.27?

No, it had happened with 2.4.20 kernel.

>
> The system is really stuck when it crashes. My wireless keyboard has a 
> led to indicate traffic, an when system hangs, not even the led would 
> blink, it just stays in either on or off state (its normaly off). No 
> disk activity, mouse is locked, display remains unchanged (x.org nv or 
> plain (non-fbdev) console). Havent tried so far to reach the box over 
> network, but is suspect it will not work.
>
> @developers:
> Maybe thats a hint, could it be that a broken keyboard induces such 
> behaviour?
>
> Im going to change kernel to 2.4.24 (had uptimes > 14 days with it) 
> and see if it helps.
>
> As far as i can see, nothing was written to the logs, no messages, it 
> just peacefully dies...

In my case it has happened with and without keyboard and with keyboard 
connected to D-Link KVM Switch

>
> zergio schrieb:
>
>> Hello, all!
>> I‘m not sure that the below problem is kernel related, however, I 
>> think, this mailing list is the best place to start. I've got 2x1.8 
>> Xeon on Intel SE7500CW2 motherboard with Intel SCSI RAID (GDT 
>> driver). The system powered by Red Hat Linux 7.3 with custom kernel 
>> version 2.4.27.
>> Occasionally, the system just hangs, without giving any error messages 
>
> how long is occasionaly?

There is no strict period of time. Some time server up for couple of 
month. Recently the issue occured twice within 7 days.
It've happened 7 time during last half a year or so.

>> to syslog or any panic-like messages to the screen. No response to 
>> ping. Usually it happens on weekends in early hours, but not at 
>> particular time and day, when users’ activity is minimal. Couple of 
>> times the last few messages before, the hang had strange timestamps. 
>> It seems like the system time entered a TIME LOOP within a period of 
>> 1 second.
>> Nov 6 05:37:31 service dhcpd: Message...
>> Nov 6 05:37:32 service named: Message...
>> Nov 6 05:37:31 service named: Message...
>> Almost all the time last messages came from different services, 
>> except three times, when mgetty was the last. I'd updated mgetty, 
>> pppd, kernel (from 2.4.20), BIOS, dhcpd etc., however, the problem 
>> remains.
>> Can anyone tell me, how I can detect, what application or hardware 
>> cause such a problem.
>> Any ideas would be appreciated.
>> Thank you in advance
>>
>> These are services being run on the server:
>> gpm
>> named
>> iptables
>> crond
>> ldap
>> smb
>> xinetd (swat amanda)
>> autofs
>> nfs
>> qmail
>> sqwebmail
>> dhcpd
>> ups
>> sshd
>> firebird
>> ntpd
>> httpd
>> arpwatch
>> drwebd
>> mgetty
>> pppd
>> postgresql
>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>

