Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTLONQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 08:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTLONQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 08:16:50 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:13283 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263598AbTLONQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 08:16:49 -0500
Date: Mon, 15 Dec 2003 14:16:47 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <200312131356.16016.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0312151413480.26565@jurand.ds.pg.gda.pl>
References: <200312131356.16016.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Dec 2003, Ross Dickson wrote:

> Please consider adding
> 
> 2c. Alternatively the OUT0 output of the 8254 PIT (IOW the timer source) may be 
> directly connected to the INTIN0 input of the first I/O APIC. 
> 
> which we have found for nforce2 boards.

 Actually the code can handle routing to any INTIN pins, so the whole text
needs to be reworded.  It's just that I've got used to INTIN0 and INTIN2
after that many years. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
