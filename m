Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUBIEAH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 23:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbUBIEAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 23:00:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:39053 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264305AbUBIEAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 23:00:05 -0500
Subject: Re: PATCH: I2C is missing on 2.6.2 with ppc arch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Barisani <lcars@infis.univ.trieste.it>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040206134619.GA23338@sole.infis.univ.trieste.it>
References: <20040206134619.GA23338@sole.infis.univ.trieste.it>
Content-Type: text/plain
Message-Id: <1076299081.895.114.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 09 Feb 2004 14:58:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-07 at 00:46, Andrea Barisani wrote:
> Hi guys,
> 
> i2c support is missing on 2.6.2 with ppc arch, it was present on 2.6.1 and
> it's needed for many things, most notably dmasound_pmac support.

Well... I don't know what's up with 2.6.2, but 2.6.3-rc now uses
drivers/Kconfig anyway, so this patch isn't needed.

Ben.


