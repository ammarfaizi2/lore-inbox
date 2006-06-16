Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWFPU3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWFPU3G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 16:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWFPU3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 16:29:06 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:3085 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751515AbWFPU3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 16:29:04 -0400
Date: Fri, 16 Jun 2006 22:29:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
Message-Id: <20060616222908.f96e3691.khali@linux-fr.org>
In-Reply-To: <1150406598.1193.73.camel@localhost.localdomain>
References: <20060615225723.012c82be.khali@linux-fr.org>
	<1150406598.1193.73.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

> > So basically we have two drivers in the kernel tree for 5 years or so,
> > which never were usable, and nobody seemed to care. 
> 
> For historical correctness, this driver was once upon a time usable,
> though it was a few years ago. It was written by MV for some ref board
> that had the ITE chip and it did work. That ref board is no longer
> around so it's probably safe to nuke the driver. 

In which kernel version? In every version I checked (2.4.12, 2.4.30,
2.6.0 and 2.6.16) it wouldn't compile due to struct iic_ite being used
but never defined (and possibly other errors, but I can't test-compile
the driver.)

-- 
Jean Delvare
