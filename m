Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318204AbSHIJLa>; Fri, 9 Aug 2002 05:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSHIJLa>; Fri, 9 Aug 2002 05:11:30 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:61956 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318204AbSHIJL3>;
	Fri, 9 Aug 2002 05:11:29 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [OT] 2.4.19 BUG in page_alloc.c:91 
In-reply-to: Your message of "Thu, 08 Aug 2002 14:19:48 +0200."
             <m17cmFU-003oZpC@zeus.domdv.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Aug 2002 19:14:59 +1000
Message-ID: <2596.1028884499@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002 14:19:48 +0200 (CEST), 
Andreas Steinmetz <ast@domdv.de> wrote:
>On 08 Aug 2002 13:38:56 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>Rik and Alan,
>not exactly related but please don't be too persistent about "Tainted: P".
>Just try to insmod xircom_tulip_cb of a stock 2.4.19 kernel and, surprise:
># insmod xircom_tulip_cb
>Using /lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_tulip_cb.o
>Warning: loading
>/lib/modules/2.4.19/kernel/drivers/net/pcmcia/xircom_tulip_cb.o will taint the 
>kernel: non-GPL license - GPL v2

Upgrade to modutils >= 2.4.17.  Somebody added 'GPL v2' to a module
license without checking if it was acceptable or not.  The definitive
list of acceptable licenses is in include/linux/module.h.

