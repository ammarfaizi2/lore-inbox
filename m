Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271324AbTG2HtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271329AbTG2HtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:49:24 -0400
Received: from [217.157.19.70] ([217.157.19.70]:15119 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S271324AbTG2HtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:49:22 -0400
Date: Tue, 29 Jul 2003 09:49:20 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: 100-Watt Puppeteer -- 100-Watt Puppeteer <jtc@bmnetwerks.net>,
       =?ISO-8859-2?Q?G=E1l_Viktor?= <galv@mit.bme.hu>,
       Jonas Lundgren <neonman@linuxmail.org>,
       Patrick Scharrenberg <pittipatti@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image SiI3112 SATA software RAID driver
In-Reply-To: <Pine.LNX.4.40.0307282157090.15787-100000@jehova.dsm.dk>
Message-ID: <Pine.LNX.4.40.0307290946400.20824-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Thomas Horsten wrote:

> Then do:
>   dd if=/dev/hde of=hde_superblock bs=512 seek=160070144

Sorry, it must be "skip" not "seek" or this will fail.

So, the correct command in the example is:
  dd if=/dev/hde of=hde_superblock bs=512 skip=160070144

Regards,

Thomas

