Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbULRPSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbULRPSk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 10:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbULRPSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 10:18:40 -0500
Received: from mail.tmr.com ([216.238.38.203]:40639 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261177AbULRPSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 10:18:13 -0500
Message-ID: <41C44C3D.2010909@tmr.com>
Date: Sat, 18 Dec 2004 10:26:53 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: manu@kromtek.com
CC: Brad Campbell <brad@wasp.net.au>, David Lawyer <dave@lafn.org>,
       Pavel Machek <pavel@suse.cz>, Park Lee <parklee_sel@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Issue on connect 2 modems with a single phone line
References: <41C3D5AD.7090507@wasp.net.au><41C3D5AD.7090507@wasp.net.au> <200412181145.59211.manu@kromtek.com>
In-Reply-To: <200412181145.59211.manu@kromtek.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham wrote:
> On Sat December 18 2004 11:01 am, Brad Campbell wrote:
> 
>>David Lawyer wrote:
>>
>>>On Thu, Dec 16, 2004 at 02:01:38AM +0100, Pavel Machek wrote:
>>>
>>>>Hi!
>>>>
>>>>
>>>>> I want to try serial console in order to see the
>>>>>complete Linux kernel oops.
>>>>> I have 2 computers, one is a PC, and the other is a
>>>>>Laptop. Unfortunately,my Laptop doesn't have a serial
>>>>>port on it. But then, the each machine has a internal
>>>>>serial modem respectively.
>>>>> Then, can I use a telephone line to directly connect
>>>>>the two machines via their internal modems (i.e. One
>>>>>end of the telephone line is plugged into The PC's
>>>>>modem, and the other end is plugged into The Laptop's
>>>>>modem directly), and let them do the same function as
>>>>>two serial ports and a null modem can do? If it is,
>>>>>How to achieve that?
>>>>
>>>>You'd need phone exchange to do this. Most modems will not talk using
>>>>simple cable. With 12V power supply and resistor phone exchange is
>>>>quite easy to emulate, but...
>>>
>>>Here's what I once wrote in Modem-HOWTO:
>>>
>>>  Most modems are designed to be connected only to telephone lines and
>>>  will not work over just a pair of wires.  This is because the
>>>  telephone company supplies the telephone line with a 40-50 volt DC
>>>  voltage which powers part of the modem.  Recall that ordinary
>>>  conventional telephones are entirely powered by the voltage from the
>>>  telephone company.  Without such a DC voltage, the modem lacks power
>>>  and can't send out data.  Furthermore, the telephone company has
>>>  special signals indicating a ring, line busy, etc.  Conventional
>>>  modems expect and respond to these signals.
>>
>>I have used analogue modems back to back for years and have *never* come
>>across a modem that sourced anything other than it's ringing signal (via an
>>opto) from the phone line. Every single modem I have here will talk to the
>>others over a straight telephone cable.
> 
> What about power ? The opto-coupler will not work without power.
> 
> 
>>Analogue modems use a line transformer to couple to the phone network
>>usually with a decoupling capacitor on the phone end of the network to
>>prevent large current flows through the transformer. They use a standard AC
> 
> The capacitor is used to prevent DC saturation of the transformer core rather 
> than doing current limiting, A capacitor cannot do current limiting. When the 
> lag changes by changing the capacitance value,  general concept is that a 
> capacitor can limit current which is very much wrong.

I think you're quibbling over terminology here, blocking the DC 
component with a decoupling capacitor does result in less current even 
though it's not "current limiting" in some strict sense of the term. 
Less voltage results in less current, even if the load on the other side 
were purely resistive. None of this is germane to the original 
discussion of using back to back modems, of course.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
