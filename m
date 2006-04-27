Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWD0HnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWD0HnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWD0HnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:43:01 -0400
Received: from smtp-out3.iol.cz ([194.228.2.91]:58782 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S932422AbWD0HnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:43:00 -0400
Date: Thu, 27 Apr 2006 09:42:11 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@silence.gardas.net
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16.11] Xircom RealPort RBEM56G-100 link change issue
In-Reply-To: <1146122314.2894.14.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.63.0604270941240.3859@silence.gardas.net>
References: <Pine.LNX.4.63.0604262337530.3859@silence.gardas.net>
 <1146122314.2894.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006, Arjan van de Ven wrote:

> On Wed, 2006-04-26 at 23:46 +0200, Karel Gardas wrote:
>> Hello,
>>
>> I'm trying to get working linux with Xircom RealPort CardBus Ethernet
>> 10/100+Modem 56 PCMCIA card. I only need ethernet working. The problem
>> with this is that I'm losing too many packets while syslog is filled with
>> messages like:
>>
>> Apr 26 23:17:31 thinkpad kernel: pccard: CardBus card inserted into slot 1
>> Apr 26 23:18:13 thinkpad kernel: PCI: Enabling device 0000:06:00.0 (0000 -> 0003)
>> Apr 26 23:18:13 thinkpad kernel: PCI: Setting latency timer of device 0000:06:00.0 to 64
>> Apr 26 23:18:13 thinkpad kernel: eth1: Xircom cardbus revision 3 at irq 11
>> Apr 26 23:19:31 thinkpad kernel: xircom cardbus adaptor found, registering as eth1, using irq 11
>> Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link status has changed
>> Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link is 100 mbit
>> Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link status has changed
>> Apr 26 23:19:52 thinkpad kernel: xircom_cb: Link is 0 mbit
>> Apr 26 23:19:54 thinkpad kernel: xircom_cb: Link status has changed
>
> you should really check your cable; the card is flip-flopping between
> link-nolink-link-nolink ...
>
> that's either a cable bug or something like a mismatching duplex...
> (well most of the time at least, in my experience)

And your experience is right! After switching the cable everything works 
as expected. Thanks a lot for your help!

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com
