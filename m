Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264862AbUE0QI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbUE0QI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264866AbUE0QI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:08:29 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:35001 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264862AbUE0QIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:08:04 -0400
Date: Thu, 27 May 2004 18:08:02 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] io-apic cleanup #3, BK-curr
In-Reply-To: <20040527133105.GA17046@elte.hu>
Message-ID: <Pine.LNX.4.55.0405271807080.10917@jurand.ds.pg.gda.pl>
References: <20040527132119.GA13185@elte.hu> <20040527133105.GA17046@elte.hu>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004, Ingo Molnar wrote:

> io_apic_sync() was introduced in 2.1.104 and it was originally done for
> masking and unmasking as well. Later the unmasking use got removed but
> the masking use lingered around. I dont think it was ever justified to
> do it and clearly since the lack of io_apic_sync() didnt break some of
> the other writes we do to the IO-APIC registers, it must be unnecessary
> in the masking case too. Maciej?

 Go ahead, sure.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
