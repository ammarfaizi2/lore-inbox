Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbTCYImz>; Tue, 25 Mar 2003 03:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbTCYImz>; Tue, 25 Mar 2003 03:42:55 -0500
Received: from beamer.mchh.siemens.de ([194.138.158.163]:48331 "EHLO
	beamer.mchh.siemens.de") by vger.kernel.org with ESMTP
	id <S261630AbTCYImy> convert rfc822-to-8bit; Tue, 25 Mar 2003 03:42:54 -0500
Message-ID: <AEEEEE93AFA5D411AF8500D0B75E4A16062A4678@BSL203E>
From: Spang Oliver <oliver.spang@siemens.com>
To: "'Badari Pulavarty'" <pbadari@us.ibm.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: AW: 2.5.64 ttyS problem ?
Date: Tue, 25 Mar 2003 09:53:30 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think Russell was right ("drivers/serial/Makefile"-thread), it's no fault in the kernel. I tried to recompile minicom (minicom-2.00.0), and it works.

regards
Oliver

> -----Ursprüngliche Nachricht-----
> Von: Badari Pulavarty [mailto:pbadari@us.ibm.com]
> Gesendet: Dienstag, 25. März 2003 00:46
> An: Duncan Sands; Spang Oliver
> Cc: 'linux-kernel@vger.kernel.org'
> Betreff: Re: 2.5.64 ttyS problem ?
> 
> 
> On Monday 24 March 2003 07:17 am, Duncan Sands wrote:
> > > has anyone another solution? I tried 2.5.62 to 2.5.65, 
> same result.
> >
> > Is this the no "serial" module problem?  It seems to have 
> been renamed
> > "8250", but not everything knows that yet...
> >
> > Duncan.
> 
> [root@elm3b81 linux-2.5.64-gcov]# minicom
> Device /dev/ttyS1 lock failed: No child processes.
> 
> [root@elm3b81 linux-2.5.64-gcov]# grep 8250 .config
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> # CONFIG_SERIAL_8250_CS is not set
> # CONFIG_SERIAL_8250_EXTENDED is not set
> # Non-8250 serial port support
> 
> - Badari
> 
