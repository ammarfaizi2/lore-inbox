Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272458AbTGZK73 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 06:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272459AbTGZK73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 06:59:29 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:20680 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S272458AbTGZK7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 06:59:25 -0400
Subject: Re: [PATCH] Re: Firmware loading problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, willy@debian.org
In-Reply-To: <20030726090458.GA16634@ranty.pantax.net>
References: <1058885139.2757.27.camel@pegasus>
	<20030722145546.GC23593@ranty.pantax.net> <1058888301.2755.8.camel@pegasus>
	 <20030726090458.GA16634@ranty.pantax.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 Jul 2003 13:14:17 +0200
Message-Id: <1059218065.2625.47.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manuel,

> > I tracked down the problem to request_firmware() or a sysfs problem.
> > With the firmware included in a header file the driver itself works
> > perfect.
> 
>  You are right, the problem was in sysfs, attached goes a patch that
>  WorksForMe (tm), please test and report.

the firmware loading of my driver is now working, thanks. If someone has
double checked the pci-sysfs.c change, please forward this patch to
Linus.

What did Marcelo say about including your backport into 2.4?

> > Attached is a sample of how I use the request_firmware() and from the
> > documentation it seems correct to me.
> 
>  Not what I was asking for, but it seams OK.

I know, but I don't have such an easy package you requested.

Regards

Marcel


