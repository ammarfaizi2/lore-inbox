Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTLPPrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 10:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLPPrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 10:47:08 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:59778 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261812AbTLPPrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 10:47:06 -0500
Date: Tue, 16 Dec 2003 16:47:03 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <Pine.LNX.4.53.0312160846530.17690@chaos>
Message-ID: <Pine.LNX.4.55.0312161645100.8262@jurand.ds.pg.gda.pl>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com>
 <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com>
 <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.53.0312160846530.17690@chaos>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Richard B. Johnson wrote:

> Masking OFF the timer channel 0 in the interrupt controller
> is probably the easiest thing to do. The port is read-write,
> and the OCW default to having it accessible.

 Note we are writing about configurations involving an I/O APIC, so things
are not that easy -- the 8254 timer IRQ may be wired in different ways.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
