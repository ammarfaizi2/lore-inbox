Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSDQQUR>; Wed, 17 Apr 2002 12:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSDQQUQ>; Wed, 17 Apr 2002 12:20:16 -0400
Received: from pop.gmx.net ([213.165.64.20]:17236 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293076AbSDQQUQ>;
	Wed, 17 Apr 2002 12:20:16 -0400
Message-ID: <3CBD92AF.9D66FB6D@gmx.net>
Date: Wed, 17 Apr 2002 17:20:15 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Ulanov <drey@rt.mipt.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
In-Reply-To: <20020417140510.GB9930@gleam.rt.mipt.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Ulanov wrote:

> Look at this:
>
> $ cat test.c
> #include <stdio.h>
>
> main()
> {
>         double h = 0.2;
>
>         if(1/h == 5.0)
>             printf("1/h == 5.0\n");
>
>         if(1/h < 5.0)
>             printf("1/h < 5.0\n");
>         return 0;
> }
> $ gcc test.c
> $ ./a.out
> 1/h < 5.0
> $
>
> I also ran same a.out under FreeBSD. It says "1/h == 5.0".
> It seems there is difference somewhere in FPU
> initialization code. And I think it should be fixed.
>
> ps. cc to me
> --
> with best regards, Andrey Ulanov.
> drey@rt.mipt.ru
>

google for every scientist should know about floating point


