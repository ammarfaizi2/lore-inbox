Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTBJRVn>; Mon, 10 Feb 2003 12:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbTBJRVn>; Mon, 10 Feb 2003 12:21:43 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:40530 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S261330AbTBJRVm>; Mon, 10 Feb 2003 12:21:42 -0500
Message-ID: <3E47E257.3000904@hotmail.com>
Date: Mon, 10 Feb 2003 09:33:11 -0800
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre4-ac3 hangs at reboot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Actually this problem started with ac2.  All seems to work well until I
reboot the machine with 'shutdown' or 'reboot' or 'ctl-alt-del'.

The machine shuts down properly to the point where all filesystems
are remounted readonly, which is the point where I normally see an
immediate reboot.  Starting with pre4-ac2 I just get an indefinite
hang instead of the reboot.

The terminal driver still seems to work because I can use the
ctl-alt-Fx keys to switch to other pseudo-terminals but the login
process is already gone so I can't actually do anything at the
login prompts.  It takes a hard reset to complete the reboot,
after which the machine comes up normally with clean filesystems.

I see this on three different machines with different motherboards
and CPU's [K6-2, athlon, athlon-xp], two VIA chipsets and one SiS.

No error messages print anywhere, so I'm not sure how to debug.
Do you need a kernel config file or dmesg output?


