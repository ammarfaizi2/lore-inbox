Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129280AbQJ1K5f>; Sat, 28 Oct 2000 06:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbQJ1K5Y>; Sat, 28 Oct 2000 06:57:24 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:18180 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129280AbQJ1K5K>;
	Sat, 28 Oct 2000 06:57:10 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Markus.Hennig@astaro.de
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0test5 make dep errors 
In-Reply-To: Your message of "Fri, 27 Oct 2000 13:01:32 +0200."
             <39F9608C.A329F945@astaro.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Oct 2000 21:57:02 +1100
Message-ID: <7788.972730622@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000 13:01:32 +0200, 
Markus hennig <hennig@astaro.de> wrote:
>config.c:311: #error "HiSax: No cards configured"
>su.c:75: asm/oplib.h: No such file or directory
>su.c:77: asm/ebus.h: No such file or directory
>newport.c:11: asm/gfx.h: No such file or directory
>newport.c:12: asm/ng1.h: No such file or directory
>tcsyms.c:7: asm/dec/tc.h: No such file or directory
>zorro.c:20: asm/amigahw.h: No such file or directory

All (unfortunately) normal because make dep scans all source before any
generated .h files are created.  Ignore, will be fixed in 2.5.

>/usr/src/linux/Rules.make:145: target `_subdir_sched' given more than
>once in the same rule.

Annoying but AFAIK it is harmless.  Also to be fixed in 2.5.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
