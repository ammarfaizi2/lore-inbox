Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbUKSXJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUKSXJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUKSXHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:07:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:29327 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261677AbUKSXGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:06:37 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1100872578.3692.7.camel@mhcln03>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz>  <1100872578.3692.7.camel@mhcln03>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 20 Nov 2004 10:06:03 +1100
Message-Id: <1100905563.3812.59.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Of course it is :) It's more a proof-óf-concept that pci-resume is
> indeed causing the problem. I have no idea how to debug this any
> further. In the meantime this patch works for me.
> 
> >  You probably should provide resume method
> > for your radeon that just does nothing. That should confirm your
> > theory, fix the crash, and you'll avoid touching common code with it.
> 
> Sorry, that's beyond my abilities. That's why I'm posting here. I'm not
> even sure that it's the radeon which is acting up here.

Have you tried with radeonfb in your kernel config ?

Ben.


