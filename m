Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbUAVAZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 19:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUAVAZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 19:25:47 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:13832 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S266101AbUAVAZp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 19:25:45 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [2.6.1 + cset-20040120_0206] AHA152X building error
Date: Thu, 22 Jan 2004 01:25:00 +0100
User-Agent: KMail/1.5.94
Cc: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58L.0401201043380.3210@alpha.zarz.agh.edu.pl> <20040121155501.4defb5b2.rddunlap@osdl.org>
In-Reply-To: <20040121155501.4defb5b2.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401220125.00864.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia czw 22. stycznia 2004 00:55, Randy.Dunlap napisa³:

> |   LD [M]  drivers/scsi/pcmcia/aha152x_cs.o
> |
> | drivers/scsi/pcmcia/aha152x_core.o(.init.text+0x0): In function 
`init_module':
> | : multiple definition of `init_module'
> |
> | drivers/scsi/pcmcia/aha152x_stub.o(.init.text+0x0): first defined here
> | ld: Warning: size of symbol `init_module' changed from 22 in
> | drivers/scsi/pcmcia/aha152x_stub.o to 1212 in
> | drivers/scsi/pcmcia/aha152x_core.o
[...]
>
> Are you sure that this is on 2.6.1 + changes?
> I couldn't reproduce it there.
It was broken here
http://linus.bkbits.net:8080/linux-2.5/cset@1.1474.93.7?nav=index.html|
ChangeSet@-3w

and fixed here
http://linus.bkbits.net:8080/linux-2.5/cset@1.1474.115.2?nav=index.html|
ChangeSet@-3w

> We do have this same problem in 2.4.25-preN.
Any fix on that since source of problem is already known?

> ~Randy
> kernel-janitors project:  http://janitor.kernelnewbies.org/

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
