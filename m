Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUHGTP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUHGTP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 15:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUHGTPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 15:15:53 -0400
Received: from asmtp-a063f31.pas.sa.earthlink.net ([207.217.120.133]:1484 "EHLO
	asmtp-a063f31.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S264231AbUHGTPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 15:15:50 -0400
Message-ID: <41152A64.6060405@networkstreaming.com>
Date: Sat, 07 Aug 2004 14:15:48 -0500
From: Davy Durham <davy@networkstreaming.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yapo Sebastien <sebastien.yapo@e-neyret.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: disabling all video
References: <4113E0FE.1040506@networkstreaming.com> <200408070008.42519.sebastien.yapo@e-neyret.com>
In-Reply-To: <200408070008.42519.sebastien.yapo@e-neyret.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: fecd8eaa9fd3d07f1b1abadc42a7f14674bf435c0eb9d47882885355c204f66bb15fc9216f987525d366a8a9832c3824350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.206.95.96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps is there a way/trick to accomplish this by explicitly breaking 
(*at* runtime/kernel-parameter-time) the vga support that wouldn't cause 
a panic?

Yapo Sebastien wrote:

>>Question: I would like the kernel not to use any of the video hardware
>>on the machine.  Is there any run-time kernel parameter I can pass to
>>disable all video?  (I tried console= to direct output to the serial
>>port, but ttys were still using the vga hardware.)  My video card is
>>built onto the mother board, and there is no way I see to disable it
>>from the BIOS.
>>
>>    
>>
>Remove "if EMBEDDED" in the VT and VT_CONSOLE section of drivers/char/Kconfig 
>then reconfigure your kernel.
>You should find the old VT options in Device Drivers  -> Character devices
>
>Regards
>
>Sebastien
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

