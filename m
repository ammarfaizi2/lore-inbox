Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTK0IOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 03:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTK0IOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 03:14:50 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:42635
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S264445AbTK0IOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 03:14:48 -0500
Message-ID: <3FC5B274.8040303@free.fr>
Date: Thu, 27 Nov 2003 09:14:44 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [kernel panic @ reboot in usbcore] 2.6.0-test10-mm1 (culprit:
 modem_run)
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com> <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com> <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com> <3FC54C7E.50904@free.fr> <Pine.LNX.4.58.0311262213080.1683@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0311262213080.1683@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> 
> Yes please get it all done =) Especially the first line and the bottom
> "Code:" line.
>

Hmm either the "Code:" line was not available, or I simply forgot to 
write it  :-/
Here is all the info I have written:


CPU: 0
EIP: 0060 : [<d0ae9822>]
EFLAGS: 00010246
EIP is at releaseintf+0x62/0x80 [usbcore]
eax:00000000 ebx:ceddc224 ecx:cs6D5DC0 edx:00000000
esi:ceddc200 edi:00000000 ebp:cd647f0c esp:cd647ef8
ds: 007b es:007b ss:0068

Process: modem_run (pid: 1121, threadinfo=cd646000, task=ce644040)
Stack: c016ffe3 ce0bfb24 ce6d5dc0 00000000 cffe4dc0 cd647f24 d0ae9c27
        00000000 ce773800 00000000 cd647f48 c0157a5c ce529240 ce773800
        ce511000 ce773800 00000000 cf699c80 cd647f64 c0156047 ce773800

Call trace
[<c016ffe3>] iput+0x63/0x80
[<d0ae9c27>] usbdev_release+0xb7/0xc0 [usbcore]
[<c0157a5c>] __fput+0x10c/0x120
[<c0156047>] filp_close+0x57/0x80
[<c0123d17>] put_files_struct+0x67/0xd0
[<c012491e>] do_exit+0x3a/0xb0
[<c0124c4a>] do_group_exit+0x3a/0xb0
[<c02a302e>] sysenter_past_esp+0x43/0x65


(If another trace is required, I'll do it... just ask!)


