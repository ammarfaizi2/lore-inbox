Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbTFNPke (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 11:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265683AbTFNPke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 11:40:34 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:31169 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265682AbTFNPkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 11:40:33 -0400
Date: Sat, 14 Jun 2003 17:54:13 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: CJ <cj@cjcj.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-ID: <20030614155413.GI15099@wohnheim.fh-wedel.de>
References: <200306131453.h5DErX47015940@hera.kernel.org> <3EEB4112.9050005@cjcj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EEB4112.9050005@cjcj.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 June 2003 08:36:50 -0700, CJ wrote:
> 
> On an old Tyan Tomcat P200 running as a diskless bridge,
> we tried unpatched 2.4.21.  A few seconds after boot:
> 
> # kernel BUG at dev.c:991!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c02adfa3>]    Not tainted
> EFLAGS: 00010212
> eax: 00010001   ebx: c10dfda0   ecx: 36b8c947   edx: 0000002e
> esi: 0000ffff   edi: c3e7e030   ebp: c3c55800   esp: c03f5e20
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c03f5000)
> Stack: c10dfda0 c03ad840 c3ed15c0 c02ae08a c10dfda0 00000000 00000246 
> c012c631
>        c039ae30 c10dfda0 00000000 c031346f c10dfda0 c10dfda0 c0313496 
>        c10dfda0
>        c031396b c10dfda0 c10dfda0 c3e5e000 00000000 51eb815f 00000000 
>        c3e92960
> Call Trace:    [<c02ae08a>] [<c012c631>] [<c031346f>] [<c0313496>] 
> [<c031369b>]
>   [<c03136f9>] [<c0313500>] [<c0313ea8>] [<c0314009>] [<c02ae639>] 
>   [<c0316100>]
>   [<c0316100>] [<c0314f58>] [<c02ae763>] [<c02ae88c>] [<c0109dca>] 
>   [<c01192e3>]
>   [<c0109f7c>] [<c0106e40>] [<c010c3d8>] [<c0106e40>] [<c0106e64>] 
>   [<c0106ed2>]
>   [<c0105000>]
> Code: 0f 0b df 03 e3 5a 38 c0 89 c8 c1 e1 10 25 00 00 ff ff 01 c8
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> Caps lock and Scroll lock blinking

Can you run that through ksymoops?
What was the last working kernel for the machine?
.config for last working kernel? (unless identical)


Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
