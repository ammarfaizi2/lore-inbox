Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268266AbTCFTsR>; Thu, 6 Mar 2003 14:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268290AbTCFTsR>; Thu, 6 Mar 2003 14:48:17 -0500
Received: from as12-5-6.spa.s.bonet.se ([217.215.177.162]:61641 "EHLO
	www.tnonline.net") by vger.kernel.org with ESMTP id <S268266AbTCFTsO>;
	Thu, 6 Mar 2003 14:48:14 -0500
Date: Thu, 6 Mar 2003 20:58:42 +0100
From: Anders Widman <andewid@tnonline.net>
X-Mailer: The Bat! (v1.63 Beta/6)
Reply-To: Anders Widman <andewid@tnonline.net>
Organization: TNOnline.net
X-Priority: 3 (Normal)
Message-ID: <1328248062.20030306205842@tnonline.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Entire LAN goes boo  with 2.5.64
In-Reply-To: <3E679878.2090807@datadirectnet.com>
References: <20030306094021$7081@gated-at.bofh.it>
 <3E679878.2090807@datadirectnet.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried  with  a  Realtek  8139B and the Intel Pro100+ adapter. The same
thing   happens.   The   LAN   goes  crazy  and all programs trying to
access or use the LAN on the Linuxbox goes super-slow or crashes.

I am rather lost when it comes to where I should begin to look.

Have not compiled in IPX, network filtering and most other things. The
only  network  card  I  have compiled in is the Rtl8139 and the Becker
Intel Pro100+ driver.

Here is my net config: http://tnonline.net/conf.png

I  have  not compiled in ACPI or APM or APIC. And they are disabled in
BIOS too.

//Anders


> I've had this happen once, but with a 2.4 kernel. I had compiled in IPX
> and configured it for autodiscovery of frame type. On boot, it would
> flip back and forth between two different types rather fast (as fast as
> the 100base NIC could do it), freaking out every piece of networking
> equipment and every computer. See if you have IPX compiled in. 
> Otherwise, run ethereal or another sniffer to see what exactly the 
> network traffic is; that might be helpful.

> Alexander

> Anders Widman wrote:
>>    Hello,
>> 
>>    Trying  out  the  2.5.64  kernel  to try to solve some IDE specific
>>    problems  with 2.4.x kernels. Now I have another problem. We have a
>>    Windows LAN and a Windows XP with WinRoute Pro as gateway.
>> 
>>    When  booting  the linux-machine with the 2.5.64 kernel the windows
>>    machine goes to 100% cpu and the switch (Dlink) goes crazy (loosing
>>    link, other machines get 100k/s instead of 10-12MiB/s etc).
>> 
>>    I  compiled  the  2.5.64  with  as  few  options  as  possible,  no
>>    netfilter, or IPSec or similar stuff.
>> 
>>    What can be the problem?
>> 
>> 
>> --------
>> PGP public key: https://tnonline.net/secure/pgp_key.txt
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/


   



--------
PGP public key: https://tnonline.net/secure/pgp_key.txt

