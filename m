Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130011AbRAPWlu>; Tue, 16 Jan 2001 17:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132091AbRAPWla>; Tue, 16 Jan 2001 17:41:30 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:36992 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S130011AbRAPWlT>; Tue, 16 Jan 2001 17:41:19 -0500
Message-ID: <001101c0800d$50efd900$548cfd3e@abc>
Reply-To: "richard.morgan9" <richard.morgan9@ntlworld.com>
From: "richard.morgan9" <richard.morgan9@ntlworld.com>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        "Urban Widmark" <urban@teststation.com>
Cc: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0101141505470.935-100000@asdf.capslock.lan>
Subject: Re: eth1: Transmit timed out, status 0000, PHY status 0000
Date: Tue, 16 Jan 2001 22:40:24 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Sun, 14 Jan 2001, Urban Widmark wrote:
>>
>> >> eth1: Transmit timed out, status 0000, PHY status 0000,
>> >> resetting...
>> >[snip]
>> >> Keeps going nonstop until I ifdown eth1.
>> >>
>> >> Card worked fine 2 days ago...
>> >
>> >So what did you change?
>>
>> Nothing.
>>
>> >Has the machine been up since then?
>>
>> No.  I rebooted to W98 a few times.  W98 doesn't have a driver
>> installed for that card though - and wont.
>>
>>
>>
>> >Someone else with the same symptoms (in 2.4)
>> >    http://www.uwsg.iu.edu/hypermail/linux/net/0011.0/0027.html
>> >
>> >Becker's reply
>> >    http://www.uwsg.iu.edu/hypermail/linux/net/0011.0/0032.html
>> >
>> >"Try unplugging the system and doing a really cold boot. A soft-off does
>> > not reset the chip.
>>
>> Tried that too.. didn't work.  I switched PCI slots and whatnot
>> though and it works again..  <shrug>
>>
>
>> > If this solves the problem, we will have to add code to re-load the
>> > EEPROM info into the chip."
>>
>> If the problem recurs I will try to test it out more and report
>> to the list.
>>
>> FWIW it is a DLink DFE 530TX.
>>
snip

I have the same problem as Urban with a recent DLink 530tx
(rhine2).  Pulling the power cable from my atx psu (while the
computer was "off") fixed the card, until my next reboot from
win98.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
