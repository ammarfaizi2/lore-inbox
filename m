Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130322AbRAWXFz>; Tue, 23 Jan 2001 18:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130866AbRAWXFo>; Tue, 23 Jan 2001 18:05:44 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:16822 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130322AbRAWXFh>; Tue, 23 Jan 2001 18:05:37 -0500
Message-ID: <3A6E0E22.287F957C@Home.net>
Date: Tue, 23 Jan 2001 18:05:06 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Carlo Scarfoglio <carlo@mail.mclink.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre patches do no compile
In-Reply-To: <3A6E0AFE.6BCD3257@arpacoop.it>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlo Scarfoglio wrote:

> Compilation ends with an error:
> init.main.o: In function 'check_fpu':
> init/main.o(.text.init+0x63): undefined reference to
> '__buggy_fxsr_alignment'
> make: *** vmlinux] Error 1
> Kernel 2.4.0 compiles OK.
>

I had this problem, If your using PGCC 2.95.2/3 or any other GCC thats not
2.95.2 or egcs-1.1.2 it wont compile.

Change your GCC Compiler it will work :)

Shawn.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
