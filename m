Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTFEIz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 04:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTFEIz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 04:55:27 -0400
Received: from ns0.eris.dera.gov.uk ([128.98.1.1]:38258 "HELO
	ns0.eris.dera.gov.uk") by vger.kernel.org with SMTP id S264535AbTFEIzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 04:55:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7-ac1
Date: Thu, 5 Jun 2003 10:02:53 +0100
User-Agent: KMail/1.4.3
References: <200306042248.h54Mm7l16828@devserv.devel.redhat.com>
In-Reply-To: <200306042248.h54Mm7l16828@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306051002.54089.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Alan,

I wonder if you could confirm whether the usb-ohci module should be loaded 
automatically if I have the following line in modules.conf (this is with 
2.4.21-rc6-ac2)

probeall usb-interface usb-ohci

I have a Dell 2650 server with a ServerWorks chipset and its not being loaded 
automagically at boot as it does under my Mandrake kernels.

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05) 
(prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at fe100000 (32-bit, non-prefetchable) [size=4K]

Cheers,

Mark.

- -- 
Mark Watts
Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+3wc+Bn4EFUVUIO0RAm5KAKDJphtcqSaCIXmaMFQduISrOMKL7QCeLOwp
4IB+rZ++9ppY7EDv4rMApQ4=
=FVbL
-----END PGP SIGNATURE-----

