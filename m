Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUFMQEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUFMQEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 12:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUFMQEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 12:04:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:45250 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265198AbUFMQEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 12:04:31 -0400
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [4/12]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20040611190639.GC12953@linux-sh.org>
References: <200406111755.02325.bzolnier@elka.pw.edu.pl>
	 <20040611181106.GB12953@linux-sh.org>
	 <200406112047.58373.bzolnier@elka.pw.edu.pl>
	 <20040611190639.GC12953@linux-sh.org>
Content-Type: text/plain
Message-Id: <1087142338.8210.178.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 13 Jun 2004 10:58:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's used for the DMA channel number, or NO_DMA for falling back on PIO.

It is a chipset/platform specific information and has no meaning outside
of the chipset driver, thus it should be in the chipset local state data
structures and not in the common one.

Ben.


