Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131500AbRCQB6v>; Fri, 16 Mar 2001 20:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131503AbRCQB6l>; Fri, 16 Mar 2001 20:58:41 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:30212 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131500AbRCQB6W>;
	Fri, 16 Mar 2001 20:58:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ted Gervais <ve1drg@ve1drg.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2-ac20 
In-Reply-To: Your message of "Fri, 16 Mar 2001 11:40:42 EDT."
             <Pine.LNX.4.21.0103161138110.5008-100000@ve1drg.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Mar 2001 12:57:36 +1100
Message-ID: <15935.984794256@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001 11:40:42 -0400 (AST), 
Ted Gervais <ve1drg@ve1drg.com> wrote:
>unix:/etc# insmod soundmodem
>Using /lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o
>/lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o: unresolved symbol hdlcdrv_transmitter_Rccccc7c3

Either you forgot to load hdlcdrv.o first (modprobe soundmodem would be
better than insmod soundmodem) or you have been bitten by the broken
Makefiles (see http://www.tux.org/lkml/#s8-8).

