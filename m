Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBQHRj>; Sat, 17 Feb 2001 02:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbRBQHR3>; Sat, 17 Feb 2001 02:17:29 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:13330 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129072AbRBQHRQ>;
	Sat, 17 Feb 2001 02:17:16 -0500
Message-ID: <3A8E2577.6044E496@sh0n.net>
Date: Sat, 17 Feb 2001 02:17:11 -0500
From: Shawn Starr <Shawn.Starr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkm <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM]: grep hanging with ReiserFS - More info
In-Reply-To: <3A8E2467.FC6FE1B4@sh0n.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux coredump 2.4.2-pre3 #1 Fri Feb 9 20:57:39 EST 2001 i586 unknown
Kernel modules         2.3.21
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1
Linux C Library        2.2.1
Dynamic linker         ldd (GNU libc) 2.2.1
Procps                 2.0.7
Mount                  2.10r
Net-tools              1.58
Console-tools          0.2.3
Sh-utils               2.0j
Modules Loaded         nls_cp437 vfat fat

Shawn Starr wrote:

>  grep -r "216.234.235.46" *
>
> ...waiting...
>
> ./debugps | more
> USER       PID COMMAND          WCHAN
> root         1 init             do_select
> ....
> root         7 [kreiserfsd]     -
> .....
>
> root     28438 grep -r 216.234. pipe_wait
>
> Im using grep in /etc and its just waiting....
> it should have finished.
>
> Shawn.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

