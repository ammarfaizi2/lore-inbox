Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUJTPMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUJTPMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268340AbUJTPHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:07:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13952 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268197AbUJTPHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:07:14 -0400
Date: Wed, 20 Oct 2004 11:06:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ian Campbell <icampbell@arcom.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module compilation
In-Reply-To: <1098284383.29412.1741.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.61.0410201102090.12170@chaos.analogic.com>
References: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
 <1098284383.29412.1741.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Ian Campbell wrote:

> On Wed, 2004-10-20 at 15:36, Richard B. Johnson wrote:
>
>> Could whomever remade the kernel Makefile, please add
>> a variable, initially set to "", like CFLAGS_KERNEL, that
>> is exported and is always included on the compiler command-
>> line?
>
> Does the existing EXTRA_CFLAGS do what you want?
>

Well it's exported and gets on the command-line, but it's
not a "CFLAG" I want, but a definition to be passed to
the compiler. Using EXTRA_CFLAGS is no different than
using CFLAGS which, for a human readable implicit
documentation perspective, is incorrect (not a compiler flag).

> I believe you can also set CFLAGS_blah.o if you just want extra stuff
> for a single file.
>
> Ian.
>
> -- 
> Ian Campbell, Senior Design Engineer
>                                        Web: http://www.arcom.com
> Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
> Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
