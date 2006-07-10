Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWGJKDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWGJKDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWGJKDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:03:31 -0400
Received: from ip-140-150.sn2.eutelia.it ([83.211.140.150]:2711 "HELO
	intranet.antek.it") by vger.kernel.org with SMTP id S1751391AbWGJKD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:03:29 -0400
Message-ID: <44B22637.6020700@antek.it>
Date: Mon, 10 Jul 2006 12:04:39 +0200
From: Luca Ognibene <ognibene@antek.it>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: ftdi error in /var/log/messages when connecting to gprs
References: <44AD2DBF.4060200@antek.it> <20060707110004.537e2466@doriath.conectiva>
In-Reply-To: <20060707110004.537e2466@doriath.conectiva>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luiz Fernando N. Capitulino wrote:
>  Your log says:
> 
> """
> Jul  6 17:06:52 aylook012 kernel: EFLAGS: 00010282   (2.6.12-1-386)
> """
> 
>  Please, could you try to reproduce with 2.6.18-rc1 ?
> 
oops, my fault. I've tested with 2.6.16 and i've not been able to
reproduce it. Now i get (sometime) a different error:

Jul  7 17:06:36 aylook012 kernel: usb 1-2: USB disconnect, address 2
Jul  7 17:06:36 aylook012 kernel: ftdi_sio 1-2:1.0: device disconnected
Jul  7 17:06:36 aylook012 kernel: usb 1-2: new full speed USB device
using ohci_hcd and address 3
Jul  7 17:06:36 aylook012 kernel: usb 1-2: configuration #1 chosen from
1 choice
Jul  7 17:06:36 aylook012 kernel: ftdi_sio 1-2:1.0: FTDI USB Serial
Device converter detected
Jul  7 17:06:36 aylook012 kernel: drivers/usb/serial/ftdi_sio.c:
Detected FT232BM
Jul  7 17:06:36 aylook012 kernel: usb 1-2: FTDI USB Serial Device
converter now attached to ttyUSB1
Jul  7 17:06:37 aylook012 kernel: ftdi_sio ttyUSB0: FTDI USB Serial
Device converter now disconnected from ttyUSB0

I'll retry with 2.6.18-rc1 ASAP.

ciao
Luca
