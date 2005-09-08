Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVIHURD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVIHURD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVIHURD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:17:03 -0400
Received: from mail.bmts.com ([216.183.128.202]:22707 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S964984AbVIHURB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:17:01 -0400
Date: Thu, 8 Sep 2005 16:16:51 -0400
From: Mike Houston <mikeserv@bmts.com>
To: Andreas Baer <lnx1@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large File Support in Kernel 2.6
Message-Id: <20050908161651.4347678c.mikeserv@bmts.com>
In-Reply-To: <432090AE.2030200@gmx.net>
References: <20050904203725.GB4715@redhat.com>
	<20050902060830.84977.qmail@web50208.mail.yahoo.com>
	<200509041549.17512.vda@ilport.com.ua>
	<200509041144.13145.paul@misner.org>
	<84144f02050904100721d3844d@mail.gmail.com>
	<6880bed305090410127f82a59f@mail.gmail.com>
	<20050904193350.GA3741@stusta.de>
	<6880bed305090413132c37fed3@mail.gmail.com>
	<20050904203725.GB4715@redhat.com>
	<431F1778.5050200@tmr.com>
	<5.2.1.1.2.20050907194344.00c2bea8@pop.gmx.net>
	<43208B77.9060009@tmr.com>
	<432090AE.2030200@gmx.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Sep 2005 21:27:42 +0200
Andreas Baer <lnx1@gmx.net> wrote:


> I think it's 2TB for the file size and 2e73 for the file system, but
> I don't understand the second reference and the part about the
> CONIFG_LBD. What is exactly the CONFIG_LBD option?
> -

This is "Support for Large Block Devices" under Device Drivers/Block
Devices:

CONFIG_LBD:

Say Y here if you want to attach large (bigger than 2TB) discs to
your machine, or if you want to have a raid or loopback device
bigger than 2TB.  Otherwise say N.

The "2e73" refers to 2 to the exponent 73 bytes in size. Huge :-)
