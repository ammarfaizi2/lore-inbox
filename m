Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWELTSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWELTSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWELTSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:18:51 -0400
Received: from xenotime.net ([66.160.160.81]:60551 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751350AbWELTSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:18:50 -0400
Date: Fri, 12 May 2006 12:21:16 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Message-Id: <20060512122116.152fbe80.rdunlap@xenotime.net>
In-Reply-To: <20060512132437.GB4219@htj.dyndns.org>
References: <20060512132437.GB4219@htj.dyndns.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006 22:24:37 +0900 Tejun Heo wrote:

> Hello, all.
> 
> Lately libata has been going through a lot of changes and even more
> are around the corner.  I've been working on error handling and
> advanced SATA features for quite sometime now, and, finally, patches
> have been finalized and submitted for review a few days ago.
> 
> 2.6.18 is the target for mainline merge.  As there is quite some time
> between now and 2.6.18, I have made patches to update the current
> stable kernel to support the new features so that they can receive
> wider testing and interested people don't have to wait too long.  I
> intend to maintain these patches through 2.6.16 and 17 until the
> mainline merge happens.
> 
> Added new features are
> 
> * New error handling
> * IRQ driven PIO (from Albert Lee)
> * SATA NCQ support
> * Hotplug support
> * Port Multiplier support

BTW, we often use PM to mean Power Management.
Could we find a different acronym for Port Multiplier support,
such as PMS or PX or PXS?

---
~Randy
