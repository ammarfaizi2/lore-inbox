Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264397AbUE0Nau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUE0Nau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUE0Nau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:30:50 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:6021 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264397AbUE0Naf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:30:35 -0400
Date: Thu, 27 May 2004 15:30:34 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Molnar <mingo@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanups for APIC
In-Reply-To: <Pine.LNX.4.58.0405270856120.28319@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.55.0405271525140.10917@jurand.ds.pg.gda.pl>
References: <20040525124937.GA13347@elf.ucw.cz>
 <Pine.LNX.4.58.0405270856120.28319@devserv.devel.redhat.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004, Ingo Molnar wrote:

> (wrt. io_apic_sync(): i added it in 2.1.104 together with some other
> changes - i dont this it's necessary anymore - the local APICs had
> writearound erratas, but i dont remember this ever being necessary for
> IO-APICs. I'll address this in another patch.)

 Hmm, isn't that needed to make sure the iomem writeback is completed
before exiting the caller?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
