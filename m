Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277923AbRJIUdp>; Tue, 9 Oct 2001 16:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277957AbRJIUdg>; Tue, 9 Oct 2001 16:33:36 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:20270 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S277923AbRJIUdV>; Tue, 9 Oct 2001 16:33:21 -0400
Message-ID: <3BC35EF1.DB7E1824@fabbione.net>
Date: Tue, 09 Oct 2001 22:32:49 +0200
From: Fabbione <fabbione@fabbione.net>
Reply-To: fabbione@fabbione.net
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Kitwor <kitwor@kki.net.pl>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: old exploit works!!!
In-Reply-To: <Pine.LNX.3.95.1011009161252.4052A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made the same test but it just locked the xterm.

Fabbione

"Richard B. Johnson" wrote:
> 
> Erm. Doesn't work. Just creates a non-root shell with a bad
> environment. It says "Bug exploited successfully", but it's
> simply confused.
> 
> Script started on Tue Oct  9 16:07:45 2001
> $ whoami
> rjohnson
> $ gcc -o xxx c.c
> $ ./xxx
> Bug exploited successfully.
> bash$ vi /etc/passwd
> This termcap entry lacks the :cm=: capability
> This termcap entry lacks the :ce=: capability
> "/etc/passwd" [READONLY] 32 lines, 1594 chars
> :1
> root:Deleted:0:0:System Administration:/root:/bin/bash
> :w!
> Can't write to "/etc/passwd" -- NOT WRITTEN
> :q
> bash$ exit
> exit
> $ exit
> exit
> 
> Script done on Tue Oct  9 16:08:54 2001
> On Tue, 9 Oct 2001, Kitwor wrote:
> 
> > Old exploit which works on kernels up to 2.2.18 (itr doesn't work on 2.2.19)
> > works on 2.4.9!!
> > I attach that exploit.
> >
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Debian GNU/Linux Unstable Kernel 2.4.9
fabbione on irc.atdot.it #coredump #kchat | fabbione@fabbione.net
