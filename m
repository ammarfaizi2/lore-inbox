Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753465AbWKHAT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbWKHAT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 19:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbWKHAT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 19:19:27 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:17328 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1753129AbWKHAT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 19:19:27 -0500
Subject: Re: [PATCH] drivers/scsi/mca_53c9x.c : save_flags()/cli() removal
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Amol Lad <amol@verismonetworks.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061107125329.6dc4eb53.akpm@osdl.org>
References: <1162816931.22062.132.camel@amol.verismonetworks.com>
	 <20061107125329.6dc4eb53.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 09:19:12 +0900
Message-Id: <1162945152.3625.2.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 12:53 -0800, Andrew Morton wrote:

> hm.  How do we find out if this works?

I'm not sure anyone has this type of HW anymore.  It was the original
SCSI chip for the old MCA based IBM PC.  I can dig through my hardware
bins to see if I have a card, but I don't think so.

> If it _does_ work then we can now remove the Kconfig BROKEN_ON_SMP dependency
> for this driver.

Theoretically, yes ... practically I don't think there was an SMP box
produced with this chip.

James


