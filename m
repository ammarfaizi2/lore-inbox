Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVLCJ1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVLCJ1c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 04:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVLCJ1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 04:27:32 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:30953 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751225AbVLCJ1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 04:27:31 -0500
Subject: Re: Incorrect v4l patch in 2.6.15-rc4-git1
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvards@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <20051202192814.282fc10c.khali@linux-fr.org>
References: <20051202192814.282fc10c.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 03 Dec 2005 07:27:15 -0200
Message-Id: <1133602035.6724.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sex, 2005-12-02 às 19:28 +0100, Jean Delvare escreveu:
> Hi Linus,
> 
> Please revert this commit:
> 
> author	Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> 	Thu, 1 Dec 2005 08:51:35 +0000 (00:51 -0800)
> committer	Linus Torvalds <torvalds@g5.osdl.org>
> 	Thu, 1 Dec 2005 23:48:57 +0000 (15:48 -0800)
> commit	769e24382dd47434dfda681f360868c4acd8b6e2
> tree	1be728dd2f1a7f523e3de5f3f39b97a4b9905dbe
> parent	6f502b8a7858ecfa7d2a0762f7663b8b3d0808fc
> 
> [PATCH] V4L: Some funcions now static and I2C hw code for IR
> 
> - Some funcions are now declared as static
> - Added a I2C code for InfraRed.

	Please point what is so deadly broken on this trivial patch that fix a
bug where a prodution driver is using I2C code reserved for
experimentation.

Cheers, 
Mauro.

