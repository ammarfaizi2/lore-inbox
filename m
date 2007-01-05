Return-Path: <linux-kernel-owner+w=401wt.eu-S1750728AbXAEUpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbXAEUpW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbXAEUpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:45:22 -0500
Received: from mx0.towertech.it ([213.215.222.73]:39870 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750728AbXAEUpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:45:21 -0500
Date: Fri, 5 Jan 2007 21:45:09 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Woody Suwalski <woodys@xandros.com>
Subject: Re: [patch 2.6.20-rc3 1/3] rtc-cmos driver
Message-ID: <20070105214509.12190340@inspiron>
In-Reply-To: <200701051001.58472.david-b@pacbell.net>
References: <200701051001.58472.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007 10:01:57 -0800
David Brownell <david-b@pacbell.net> wrote:

> This is an "RTC framework" driver for the "CMOS" RTCs which are standard
> on PCs and some other platforms.  That's MC146818 compatible silicon.
> Advantages of this vs. drivers/char/rtc.c (use one _or_ the other, only
> one will be able to claim the RTC irq) include:

 Hi David,

  good code and well commented, thank you.
 
 I only have some comments:

 - I would put anything that is x86 related (pnp,acpi)
 in a separate file so that people working on
 non x86 systems can have a better grasp of the driver.
 
 - the name should be rtc-mc146818 to be coherent with
 the other drivers, but this can cause confusion.

 - please put yourself in MODULE_AUTHOR

 other than that, I'm fine with the code.

 I'd appreciate if someone (Woody?) can test
 this code on ARM.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

