Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVA1TzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVA1TzB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVA1TyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:54:08 -0500
Received: from smtp9.poczta.onet.pl ([213.180.130.49]:8386 "EHLO
	smtp9.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262786AbVA1Tou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:44:50 -0500
Message-ID: <41FA972F.2000604@poczta.onet.pl>
Date: Fri, 28 Jan 2005 20:49:03 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
References: <41F11F79.3070509@poczta.onet.pl>	 <d120d500050121074831087013@mail.gmail.com>	 <41F15307.4030009@poczta.onet.pl>	 <d120d500050121113867c82596@mail.gmail.com>	 <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz>	 <d120d50005012806467cc5ee03@mail.gmail.com>	 <41FA90F8.6060302@poczta.onet.pl> <d120d5000501281127752561a3@mail.gmail.com>
In-Reply-To: <d120d5000501281127752561a3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Could you please try editing drivers/input/serio/i8042.c and add
> udelay(20) before and after calls to i8042_write_data() in
> i8042_kbd_write() and i8042_command().

of course i could, will it make kernel not detect smoked AUX port? 
(problem is solved by i8042.noaux=1 cause my hardware has smoked PS/2 
port) i would rather think about testing devices before assuming thet 
work and trying to use them (maybe not as standard kernel feature, but 
it would be nice stuff for people with self-built machines where not 
everything works). Thanks for your help

---
May the Source be with you.
wixor
