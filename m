Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269882AbRHJBa6>; Thu, 9 Aug 2001 21:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269883AbRHJBat>; Thu, 9 Aug 2001 21:30:49 -0400
Received: from zok.sgi.com ([204.94.215.101]:10915 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S269882AbRHJBaa>;
	Thu, 9 Aug 2001 21:30:30 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rolf Fokkens <FokkensR@vertis.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Total freeze of 2.4 kernel 
In-Reply-To: Your message of "Thu, 09 Aug 2001 12:48:30 +0200."
             <200108091048.MAA04335@linux06.vertis.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Aug 2001 11:30:21 +1000
Message-ID: <18763.997407021@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001 12:48:30 +0200, 
Rolf Fokkens <FokkensR@vertis.nl> wrote:
>We installed a 2.4.7 kernel on a Compaq Proliant server and it makes the
>machine freeze totally at various moments.

To gather more information, try adding the kernel debugger patch [1],
booting with nmi watchdog [2] and a serial console [3].

[1] ftp://oss.sgi.com/projects/kdb/download/ix86
[2] For uni-processor, compile with CONFIG_X86_UP_IOAPIC=y,
    CONFIG_UP_NMI_WATCHDOG=y.  For SMP, boot with option
    nmi_watchdog=2.
[3] Documentation/serial-console.txt

