Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTE2K7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 06:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTE2K7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 06:59:05 -0400
Received: from [62.29.86.9] ([62.29.86.9]:57216 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S262139AbTE2K7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 06:59:04 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Christian <evil@g-house.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IPv6 module oopsing on 2.5.69
Date: Thu, 29 May 2003 14:11:32 +0300
User-Agent: KMail/1.5.9
References: <3ED5E9E7.5070602@g-house.de>
In-Reply-To: <3ED5E9E7.5070602@g-house.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305291411.32993.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 14:07, Christian wrote:
> hi,
>
> while booting the ipv6 module gets installed, along with this message in
> the log:
>
> prinz kernel: IPv6 v0.8 for NET4.0
> prinz kernel: ------------[ cut here ]------------
> prinz kernel: kernel BUG at include/linux/module.h:284!
> prinz kernel: invalid operand: 0000 [#1]
> prinz kernel: CPU:    0
> prinz kernel: EIP:    0060:[<e5b983e8>]    Tainted: P
								^^^^^^^^
> prinz kernel: EFLAGS: 00010246
> prinz kernel: eax: 00000000   ebx: 00000000   ecx: d8872e40   edx: d916eb80
> prinz kernel: esi: 0000003a   edi: e5bbfc60   ebp: d916eb80   esp: dc763efc
> prinz kernel: ds: 007b   es: 007b   ss: 0068
> prinz kernel: Process modprobe (pid: 917, threadinfo=dc762000
> task=d8cb5300) prinz kernel: Stack: e5bc1800 d916eb80 0000039c df109d70
> 00000001
> 0000000a ffffff9f d8872e40
> prinz kernel: c025bc90 d8872e40 0000003a 416d9c90 e5bc1060 00000000
> dffdadc0 00000003
> prinz kernel: c0121765 e5bc1000 dffdadc0 dffdadc0 00000000 c030d698
> e5bc1800 00000000
> prinz kernel: Call Trace: [<e5bc1800>]  [<c025bc90>]  [<e5bc1060>]
> [<c0121765>]  [<e5bc1000>]  [<e5bc1800>]  [<e498c82d>]  [<e5bc2388>]
> [<e5bc1800>]  [<e498c1bd>]  [<e5bbfc48>]  [<c01318ff>]  [<e5bc1800>]
> [<c0109137>]
> prinz kernel: Code: 0f 0b 1c 01 78 d0 bb e5 e9 d6 fd ff ff 0f 0b 1e 01
> 8f d0 bb
>

Your kernel is tainted . Remove unneeded/closed-source modules and retry to 
produce the ooops.


Regards,
/ismail
