Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTIQVMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTIQVMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:12:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:54970 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262821AbTIQVMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:12:17 -0400
Date: Wed, 17 Sep 2003 13:53:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: aknuds-1@broadpark.no, linux-kernel@vger.kernel.org
Subject: Re: Changes in siimage driver?
Message-Id: <20030917135323.1f24c88a.akpm@osdl.org>
In-Reply-To: <1063816835.12648.90.camel@dhcp23.swansea.linux.org.uk>
References: <oprvnjyf2oq1sf88@mail.broadpark.no>
	<1063816835.12648.90.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Mer, 2003-09-17 at 17:26, Arve Knudsen wrote:
> > X66 etc.) with hdparm, I get ~50MB/S. It's not an ideal solution since now 
> > and then I get a bunch of "disabling irq #18" messages after running 
> > hdparm (I think, its part of the startup scripts), and I have to restart.
> 
> That is a bug in the 2.6.0 core still.

How come this driver is returning IRQ_NONE so much?

> Just hack out the code which does
> the IRQ disable on too many apparently unidentified interrupts.

You can boot with the `noirqdebug' option to disable it.

