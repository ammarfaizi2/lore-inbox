Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274627AbRIYK5k>; Tue, 25 Sep 2001 06:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274628AbRIYK5a>; Tue, 25 Sep 2001 06:57:30 -0400
Received: from [195.66.192.167] ([195.66.192.167]:41744 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S274627AbRIYK5U>; Tue, 25 Sep 2001 06:57:20 -0400
Date: Tue, 25 Sep 2001 13:55:37 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <2418997466.20010925135537@port.imtp.ilyichevsk.odessa.ua>
To: "Dan Mann" <daniel_b_mann1@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux VM design
In-Reply-To: <OE53f3LSW50Pfs56PHo00002624@hotmail.com>
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com>
 <Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com>
 <20010921124338.4e31a635.skraw@ithnet.com>
 <20010922105332Z16449-2757+1233@humbolt.nl.linux.org>
 <6514162334.20010924123631@port.imtp.ilyichevsk.odessa.ua>
 <OE53f3LSW50Pfs56PHo00002624@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,
Monday, September 24, 2001, 10:11:08 PM, you wrote:

DM> I hope this isn't the wrong place to ask this but,  wouldn't it be better to
DM> increase ram size and decrease swap size as memory requirements grow?  For
DM> instance, say I have a lightly loaded machine, that has 192MB of ram.  From
DM> everything I've heard in the past, I'd use roughly 192MB of swap with this
DM> machine.  The problem I would imagine is that if all 192MB got used wouldn't
DM> it be terribly slow to read/write that much data back in?  Would less swap,
DM> say 32 MB make the kernel more restrictive with it's available memory and
DM> make the box more responsive when it's heavily using swap?

If you want everything to be fast, buy more RAM and use no swap whatsoever.

Swap is useful if your total memory requirements are big but working
set is significantly smaller. You need RAM to cover working set
and RAM+swap to cover total memory requirements.

As you can see, amount of RAM and swap thus *application dependent*.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


