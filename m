Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUC1HqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 02:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUC1HqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 02:46:16 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:48307 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262113AbUC1HqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 02:46:14 -0500
Message-ID: <406682B6.4030505@stesmi.com>
Date: Sun, 28 Mar 2004 09:45:58 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suze.cz>,
       torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com> <20040328002938.GA11657@wsdw14.win.tue.nl> <200403271940.39940.dtor_core@ameritech.net>
In-Reply-To: <200403271940.39940.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> linked to broken legacy emulation implementations, Vojtech mentioned
> that PCI quirk to turn legacy emulation off may be appropriate.

Is there any code available that can do that as it is now?

This would be useful especially right now under x86-64.

As it is right now I either have the keyboard plugged into
both ps/2 and usb, plug it in only into usb (can't operate
grub) or plug it only into usb (enable emulation, can't
run linux ... ) and if the kernel could have a way of
disabling the emulation that would be good at least in
my case.

// Stefan
