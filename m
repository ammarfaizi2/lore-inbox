Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVA1UVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVA1UVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVA1UUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:20:47 -0500
Received: from smtp7.poczta.onet.pl ([213.180.130.47]:15081 "EHLO
	smtp7.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262755AbVA1USI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:18:08 -0500
Message-ID: <41FA9EFC.9040600@poczta.onet.pl>
Date: Fri, 28 Jan 2005 21:22:20 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
References: <41F11F79.3070509@poczta.onet.pl>	 <d120d500050121074831087013@mail.gmail.com>	 <41F15307.4030009@poczta.onet.pl>	 <d120d500050121113867c82596@mail.gmail.com>	 <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz>	 <d120d50005012806467cc5ee03@mail.gmail.com>	 <41FA90F8.6060302@poczta.onet.pl>	 <d120d5000501281127752561a3@mail.gmail.com>	 <41FA972F.2000604@poczta.onet.pl> <d120d50005012811534eb1ed70@mail.gmail.com>
In-Reply-To: <d120d50005012811534eb1ed70@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> We do test AUX port and your port appears to be perfectly functional
> from the kernel point of view - it porperly responds to AUX_LOOP
> commands, does not claim to support MUX mode and KBC properly sets
> status register when asked to disable interface...

ok, but how AUX block KBD port? if procesor-interface works, it 
shouldn't disturb communication in any way! how it is possible that 
tests do not detect broken down port? if kernel enables it in some way 
(when disabling port from command line, KBD works ok), it should be 
detected that AUX does not work correctly and lock it somehow? can it be 
etermined by analyzing data flow? or maybe tests are not enought good, 
maybe some corelations when using both KBD and AUX exist and are not 
tested? as my keyboard works now, i'm not keen on solving this, but to 
make the world better and dominate it, some "runtime hardware failures 
handling" could be added.

--
May the Source be with you.
wixor
