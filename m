Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275994AbRI1KC1>; Fri, 28 Sep 2001 06:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275996AbRI1KCS>; Fri, 28 Sep 2001 06:02:18 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:25618 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275994AbRI1KCF>;
	Fri, 28 Sep 2001 06:02:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Zakhar Kirpichenko <zakhar@mirotel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.9-ac15 and -ac16 compile error 
In-Reply-To: Your message of "Fri, 28 Sep 2001 12:00:33 +0300."
             <Pine.LNX.4.33.0109281153060.25965-100000@dionis.mirotel.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Sep 2001 20:02:20 +1000
Message-ID: <18735.1001671340@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001 12:00:33 +0300 (EEST), 
Zakhar Kirpichenko <zakhar@mirotel.net> wrote:
>	I've got a problem compiling linux-2.4.9-ac15 and -ac16. When I'm
>trying to compile APM support as module, I get this during depmod section
>of 'make modules_install' (and when start 'depmod' manually):
>
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.9-z6; fi
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.9-z6/kernel/arch/i386/kernel/apm.o
>depmod: 	__sysrq_unlock_table

Turn on CONFIG_MAGIC_SYSRQ for now, there will be a fix in a later kernel.

