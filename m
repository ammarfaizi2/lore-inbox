Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316291AbSELB1s>; Sat, 11 May 2002 21:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316294AbSELB1r>; Sat, 11 May 2002 21:27:47 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:53515 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316291AbSELB1r>;
	Sat, 11 May 2002 21:27:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "skidley" <skidley@crrstv.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac2 compile error 
In-Reply-To: Your message of "Sat, 11 May 2002 21:56:40 -0300."
             <20020512005640.GA2171@crrstv.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 May 2002 11:27:35 +1000
Message-ID: <17777.1021166855@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002 21:56:40 -0300, 
"skidley" <skidley@crrstv.net> wrote:
>
>make[1]: Leaving directory `/home/kernel/linux/Documentation/DocBook'
>gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
>scripts/split-include scripts/split-include.c
>scripts/split-include include/linux/autoconf.h include/config
>make -r -f .tmp_include_depends all
>make[1]: Entering directory `/home/kernel/linux'
>make[1]: .tmp_include_depends: No such file or directory
>make[1]: *** No rule to make target `.tmp_include_depends'.  Stop.
>make[1]: Leaving directory `/home/kernel/linux'
>make: *** [.tmp_include_depends] Error 2

You forgot to make dep after applying the patch.

