Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTDVOra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTDVOra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:47:30 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:49072 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S263182AbTDVOra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:47:30 -0400
Date: Tue, 22 Apr 2003 16:59:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
In-Reply-To: <3EA41684.6030502@kolumbus.fi>
Message-ID: <Pine.GSO.3.96.1030422165656.20928A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, [ISO-8859-1] Mika Penttilä wrote:

> Why can't we use the same vector for multiple ioapic entrys? After all, 
> we are already sharing irqs, and an irq is just a cookie for a vector. 

 IIRC, there are serious issues with using the same vector for multiple
I/O APIC interrupts, at least for certain implementations.  So it's
probably not even worth investigating. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

