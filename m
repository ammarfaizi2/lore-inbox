Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTIRMQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTIRMQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:16:00 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:64940 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261214AbTIRMP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:15:59 -0400
Subject: Re: Changes in siimage driver?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: aknuds-1@broadpark.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030917135323.1f24c88a.akpm@osdl.org>
References: <oprvnjyf2oq1sf88@mail.broadpark.no>
	 <1063816835.12648.90.camel@dhcp23.swansea.linux.org.uk>
	 <20030917135323.1f24c88a.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063887264.15957.16.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Thu, 18 Sep 2003 13:14:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-17 at 21:53, Andrew Morton wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> > On Mer, 2003-09-17 at 17:26, Arve Knudsen wrote:
> > > X66 etc.) with hdparm, I get ~50MB/S. It's not an ideal solution since now 
> > > and then I get a bunch of "disabling irq #18" messages after running 
> > > hdparm (I think, its part of the startup scripts), and I have to restart.
> > 
> > That is a bug in the 2.6.0 core still.
> 
> How come this driver is returning IRQ_NONE so much?

Lots of IDE interrupts get cleared directly in other code paths but I'm
not sure. I just know its happening.

