Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272070AbTG2UtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272115AbTG2UtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:49:24 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:2200 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272070AbTG2UtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:49:19 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jan Huijsmans <huysmans@xs4all.nl>
Date: Tue, 29 Jul 2003 22:49:02 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test 2 & matroxfb or orinoco wifi card
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <8A3FF3E321C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 03 at 22:35, Jan Huijsmans wrote:
> After digging a bit in the archives I couldn't find the solution to my problem,
> so I'm asking you guys.

It is bug in matroxfb. I sent patch to Linus already, but it did not found
its way through his email filters yet. I'll try again...

> I found the "matroxfb and 2.6.0-test2" thread, so it's possible to compile the
> kernel with the matrox framebuffer, but I can't find what I'm missing. Did I
> forget to set a config option (all copied from the 2.4.21 config except the
> nForce2 agp chipset)?

But anyway, you are trying to build your kernel without virtual terminal
support (and, BTW, did you enable support for keyboard?) and it is probably
not what you want. 

If you really insist on kernel without VT support (your screen will be
black! your monitor will poweroff...), you can apply patch from
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-novt.gz.
                                        Best regards,
                                            Petr Vandrovec

