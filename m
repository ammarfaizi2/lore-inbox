Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUCWK3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUCWK3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:29:43 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:36496 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262442AbUCWK3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:29:41 -0500
Date: Tue, 23 Mar 2004 11:29:40 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Robert_Hentosh@Dell.com,
       fleury@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.53.0403221701460.24245@chaos>
Message-ID: <Pine.LNX.4.55.0403231127110.16819@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0403222105380.3493-100000@poirot.grange>
 <Pine.LNX.4.53.0403221701460.24245@chaos>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Richard B. Johnson wrote:

> First, you are using the 8259A (XT-PIC). This means you have
> IO-APIC turned off (or it doesn't exist).

 An I/O APIC can be used for the wirtual-wire mode as well.  Using the
8259A doesn't preclude using an I/O APIC semi-transparently, with ExtINTA
messages travelling across the inter-APIC bus (depending on an APIC
implementation).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
