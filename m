Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUECUIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUECUIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUECUIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:08:46 -0400
Received: from [81.219.144.6] ([81.219.144.6]:56593 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263943AbUECUH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:07:58 -0400
Message-ID: <4096A697.2020707@pointblue.com.pl>
Date: Mon, 03 May 2004 21:07:51 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Hamie <hamish@travellingkiwi.com>, linux-kernel@vger.kernel.org
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <20040503123150.GA1188@openzaurus.ucw.cz> <40965DAA.4040504@pointblue.com.pl> <20040503192940.GA3531@elf.ucw.cz>
In-Reply-To: <20040503192940.GA3531@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>A: Do reboot() syscall with right parameters. Warning: glibc gets in
>its way, so check with strace:
>
>reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, 0xd000fce2)
>
>Ouch, and when you code that trivial program, send me source, I lost
>mine.
>  
>
Wouldn't it be better to just add place in proc that triggers it ?

--
GJ



