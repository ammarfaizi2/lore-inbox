Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUAVArx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 19:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUAVArx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 19:47:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:45449 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266110AbUAVArw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 19:47:52 -0500
Date: Wed, 21 Jan 2004 16:43:34 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: cieciwa@alpha.zarz.agh.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: [2.6.1 + cset-20040120_0206] AHA152X building error
Message-Id: <20040121164334.68ce12e0.rddunlap@osdl.org>
In-Reply-To: <200401220125.00864.arekm@pld-linux.org>
References: <Pine.LNX.4.58L.0401201043380.3210@alpha.zarz.agh.edu.pl>
	<20040121155501.4defb5b2.rddunlap@osdl.org>
	<200401220125.00864.arekm@pld-linux.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004 01:25:00 +0100 Arkadiusz Miskiewicz <arekm@pld-linux.org> wrote:

| Dnia czw 22. stycznia 2004 00:55, Randy.Dunlap napisa³:
| 
| > |   LD [M]  drivers/scsi/pcmcia/aha152x_cs.o
| > |
| > | drivers/scsi/pcmcia/aha152x_core.o(.init.text+0x0): In function 
| `init_module':
| > | : multiple definition of `init_module'
| > |
| > | drivers/scsi/pcmcia/aha152x_stub.o(.init.text+0x0): first defined here
| > | ld: Warning: size of symbol `init_module' changed from 22 in
| > | drivers/scsi/pcmcia/aha152x_stub.o to 1212 in
| > | drivers/scsi/pcmcia/aha152x_core.o
| [...]
| >
| > Are you sure that this is on 2.6.1 + changes?
| > I couldn't reproduce it there.
| It was broken here
| http://linus.bkbits.net:8080/linux-2.5/cset@1.1474.93.7?nav=index.html|
| ChangeSet@-3w
| 
| and fixed here
| http://linus.bkbits.net:8080/linux-2.5/cset@1.1474.115.2?nav=index.html|
| ChangeSet@-3w
| 
| > We do have this same problem in 2.4.25-preN.
| Any fix on that since source of problem is already known?

No patch yet AFAIK.

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
