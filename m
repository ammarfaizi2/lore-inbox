Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266213AbUHGBun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUHGBun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 21:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267900AbUHGBun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 21:50:43 -0400
Received: from asmtp-a063f35.pas.sa.earthlink.net ([207.217.120.220]:16029
	"EHLO asmtp-a063f35.pas.sa.earthlink.net") by vger.kernel.org
	with ESMTP id S266213AbUHGBum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 21:50:42 -0400
Message-ID: <41143570.5070705@networkstreaming.com>
Date: Fri, 06 Aug 2004 20:50:40 -0500
From: Davy Durham <davy@networkstreaming.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yapo Sebastien <sebastien.yapo@e-neyret.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: disabling all video
References: <4113E0FE.1040506@networkstreaming.com> <200408070008.42519.sebastien.yapo@e-neyret.com>
In-Reply-To: <200408070008.42519.sebastien.yapo@e-neyret.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: fecd8eaa9fd3d07f1b1abadc42a7f14674bf435c0eb9d47882885355c204f66be28ee0ef9fe3c8340f5f6141733323fa350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.206.95.96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
>  
>
Aww, is there no way to disable it at run-time?  I'm working with a 
precompiled kernel.

Perhaps there's a trick to disable the card with a special interrupt?  
Set the terminal parameters to blanked from the kernel parameter line 
(like setterm does)

Thanks
