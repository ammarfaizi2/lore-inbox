Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbUCWXG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbUCWXG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:06:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:53953 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262886AbUCWXGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:06:24 -0500
X-Authenticated: #20450766
Date: Tue, 23 Mar 2004 22:10:57 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Richard B. Johnson" <root@chaos.analogic.com>, <Robert_Hentosh@Dell.com>,
       <fleury@cs.auc.dk>, <linux-kernel@vger.kernel.org>
Subject: RE: spurious 8259A interrupt
In-Reply-To: <Pine.LNX.4.55.0403231132170.16819@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0403232206070.4385-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004, Maciej W. Rozycki wrote:

> On Tue, 23 Mar 2004, Guennadi Liakhovetski wrote:
>
> > Yes, I saw this your explanation. Thanks again. But, I am not getting
> > those errors with local APIC disabled. That's why I thought "local APIC ->
>
>  Is the local APIC normally disabled, i.e. do you see a message like:
> "Local APIC disabled by BIOS -- reenabling." when you boot with your local
> APIC enabled?  That might explain the difference.

Yes.

> what you observe.  As the local APIC latches edge-triggered interrupts it
> receives (unlike the 8259A) a glitch on an interrupt line does not have to
> last long enough for a CPU to accept it for a spurious interrupt to be
> recorded.

Ok, I'll buy it. And thanks for the explanations!

Guennadi
---
Guennadi Liakhovetski


