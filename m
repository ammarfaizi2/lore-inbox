Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVJRNsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVJRNsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 09:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVJRNsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 09:48:17 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:52819 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750721AbVJRNsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 09:48:16 -0400
Date: Tue, 18 Oct 2005 15:48:07 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Deven Balani <devenbalani@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why do we need libata to access SATA host controller low level device drivers?
Message-ID: <20051018134807.GB3843@harddisk-recovery.com>
References: <7a37e95e0510172114p6c2da139g5266e617fd9a7163@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a37e95e0510172114p6c2da139g5266e617fd9a7163@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 09:44:02AM +0530, Deven Balani wrote:
> I'm sorry if my question sounds absurd to some. I've found out through
> web sources, for the following reasons/features we need libata,

[...]

> But still at the back of my curious mind I'm looking for the most
> appropriate answer to this question that can come only come from the
> experienced linux kernel  experts of this group.

The most appropriate answer is: "cause you don't want to reinvent the
wheel". In order to get full SATA support, you only need to write a
host driver, libata takes care of the gory details.

> Now some info about myself, i'm a software engineer in india and
> developing GPL'ed (open source and Linux Kernel 2.4 based) SATA
> low-level driver for a SATA/ATAPI-6 Host Controller on a ARM 920TDMI
> based chipset.

You don't want to use a 2.4 kernel on ARM, especially not when you're
using new hardware. 2.4 is development is dead, everybody has moved to
2.6.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
