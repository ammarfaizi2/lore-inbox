Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbUABTCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265558AbUABTCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:02:46 -0500
Received: from mail.ms.so-net.ne.jp ([202.238.82.30]:18026 "EHLO
	mx02.ms.so-net.ne.jp") by vger.kernel.org with ESMTP
	id S265557AbUABTCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:02:45 -0500
Message-ID: <3FF5C015.7050806@turbolinux.co.jp>
Date: Sat, 03 Jan 2004 04:01:41 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.4) Gecko/20030925
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1 with JP106 keyboard
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <3FF4F8EA.6090602@turbolinux.co.jp> <20040102131737.GB395@ucw.cz>
In-Reply-To: <20040102131737.GB395@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Hi,
>>2.6.1-rc1 with JP106 keybord. keycode was changed....
>>                                        2.6.0 -> 2.6.1-rc1
>>lower-right backslash (scancode 0x73)   89    -> 181
>>upper-right backslash (scancode 0x7d)   183   -> 182
> 
> 
> These two scancodes are defined as japanese language selection keys.
> Hence the atkbd.c driver delivers these as such. What should be updated
> is the default keymap (defkeymap.map, defkeymap.c).
> 

Thank you so much.
I try so that it can be solved.
> What should be updated  is the default keymap (defkeymap.map, defkeymap.c).
Sorry, does this mean that a default key map is re-defined?
We need to add 181 and 182 keycodes to the keymap?

Thanks again.

