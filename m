Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbTCHBUV>; Fri, 7 Mar 2003 20:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbTCHBUV>; Fri, 7 Mar 2003 20:20:21 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:16901
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261659AbTCHBUS>; Fri, 7 Mar 2003 20:20:18 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DD7@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Bryan Whitehead'" <driver@jpl.nasa.gov>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: RE: devfs + PCI serial card = no extra serial ports
Date: Fri, 7 Mar 2003 17:30:53 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 4:59 PM, Bryan Whitehead wrote:
> 
> Quick question: What PCI serial port add on card works with devfs in 
> kernel 2.4.19 out of the box? No pissing around?
> 
> While I'm messing around with the one I got (that doesn't 
> work) I need 
> one that does... any suggestions??
> 
> Thanks to all for the help!!
> 
 [ snip ]

Bryan,

Anything in the /usr/src/linux*/drivers/char/serial.c driver's
serial_pci_tbl list (~line 4537) will be recognized. Also, a card _without_
a parallel port would solve the port ordering problem. 

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
