Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270227AbRH1EHS>; Tue, 28 Aug 2001 00:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270229AbRH1EHI>; Tue, 28 Aug 2001 00:07:08 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:58072 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S270227AbRH1EGz>;
	Tue, 28 Aug 2001 00:06:55 -0400
Message-ID: <3B8B18EA.A66C2281@candelatech.com>
Date: Mon, 27 Aug 2001 21:07:06 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: java programmer <javadesigner@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel e100 Ethernet card support in core Kernel
In-Reply-To: <20010828035026.3091.qmail@web14203.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

java programmer wrote:
> 
> Hi:
> 
> There is built in support for intel cards in the
> core kernel. My question is, whether using this
> kernel support is the best way to drive intel cards.

The intel driver is generally fast and stable, but I'm sure
it's not perfect.  Have you tried the eepro100 driver for
this NIC?

The fact that the eepro100 complains about the lockup bug,
and the e100 doesn't, probably does not mean the e100 doesn't
work around the bug too:  Intel is just more quiet about it's
hardware bugs :)

I'm not sure it will help you, but I have a listing of all the
cards I've tried (recently).  There is a 2-port Intel based NIC
on there (The Compaq one) but it may not be your particular version.
It did work very well for me.

Here's my ethernet NIC listing page:
http://www.candelatech.com/linux_ethernet.html

At any rate, you should probably send this question off to the
eepro100@scyld.com mailing list, especially if you have problems
with the eepro100 driver...

Enjoy,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
