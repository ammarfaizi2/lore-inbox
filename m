Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264619AbSJRGMK>; Fri, 18 Oct 2002 02:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSJRGMJ>; Fri, 18 Oct 2002 02:12:09 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:42472 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264619AbSJRGMI>;
	Fri, 18 Oct 2002 02:12:08 -0400
Message-ID: <3DAFA79C.7070907@candelatech.com>
Date: Thu, 17 Oct 2002 23:18:04 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: atai@atai.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Tigon3 driver problem with raw socket on 2.4.20-pre10-ac2
References: <20021018044402.42069.qmail@web10508.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Tai wrote:
> Hi, I am having problem with the (ethernet) Tigon3
> driver with Linux kernel 2.4.20-pre10-ac2.  If a
> program busily sends packets out on a raw socket
> (PF_PACKET, SOCK_RAW) on a Tigon3-chipset-based
> ethernet card (Neargear GA302T), the machine (AMD
> Athlon CPU, KT333 motherboard) locks up hard after a
> while.  No kernel panic or other error messages.  If I
> use a Intel PRO1000 card with the e1000 driver and
> identical same hardware and program otherwise, no lock
> up problem and the packets are sent properly.  Thus
> this indicates the problem is in the Tigon3 driver.
> 
> Thanks for any info on solving this problem.

I also had problems on an DUAL-AMD board, and also with a single
AMD board (SMP kernel though).  It works without problems in a P-IV
board though.  I compiled my kernels for Athlon target, and the P-IV
for the P-IV processor specifically.  I wonder if using a generic
x386 kernel would fix something...

Let me know what you find out!

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


