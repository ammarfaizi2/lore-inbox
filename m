Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSJSVBs>; Sat, 19 Oct 2002 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265685AbSJSVBr>; Sat, 19 Oct 2002 17:01:47 -0400
Received: from mail.zmailer.org ([62.240.94.4]:5252 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S265683AbSJSVBr>;
	Sat, 19 Oct 2002 17:01:47 -0400
Date: Sun, 20 Oct 2002 00:07:48 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: date <nobu@7501.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fragmentation DoS?
Message-ID: <20021019210748.GG1111@mea-ext.zmailer.org>
References: <200210191918.g9JJICT3032735@sh.7501.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210191918.g9JJICT3032735@sh.7501.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 04:18:12AM +0900, date wrote:
...
>  Here is the kernel oops message that I grabbed from messages:

This oops report is valid for your system, but provides no usefull
data, as actual memory layouts in different systems do vary. See:

   http://www.tux.org/lkml/#s4-3

Then post again.

> general protection fault: 0000
> CPU:    0
> EIP:    0010:[<c0141099>]    Not tainted
> EFLAGS: 00010246
> eax: 00000000   ebx: ffffffff   ecx: 00000018   edx: c0141080
> esi: c12c3e30   edi: ffffffff   ebp: ffffffff   esp: cfc95db0
> ds: 0018   es: 0018   ss: 0018
> Process sshd (pid: 59, stackpage=cfc95000)
> Stack: 00000000 c0feb020 c01284ca ffffffff c12c3e30 00000001 00000001
> 000000f0
>        c0feb000 c139c1a0 00000080 00000000 00000008 c12c3e30 00000246
> c12c3e38
>        000000f0 c01285f9 c12c3e30 000000f0 c0178612 00000000 00000000
> 00000008
> Call Trace:    [<c01284ca>] [<c01285f9>] [<c0178612>] [<c0131a84>]
> [<c0131b46>]
>   [<c0131d88>] [<c0132428>] [<c01231fd>] [<c0123298>] [<c0151aa0>]
> [<c01238a5>]
>   [<c0123c03>] [<c012403c>] [<c0123f40>] [<c012fd56>] [<c012fca9>]
> [<c01087eb>]
> 
> Code: f3 ab c7 43 48 00 00 00 00 8d 53 48 8d 43 4c 89 42 04 89 42
> 
>  Thanks for your time
> 
>  - nobu
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
