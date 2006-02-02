Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423052AbWBBBtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423052AbWBBBtc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423053AbWBBBtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:49:32 -0500
Received: from [81.2.110.250] ([81.2.110.250]:29408 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1423052AbWBBBtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:49:31 -0500
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Brown, Len" <len.brown@intel.com>
Cc: Tony Lindgren <tony@atomide.com>, Erik Slagter <erik@slagter.name>,
       Andrew Morton <akpm@osdl.org>, Joerg Sommrey <jo@sommrey.de>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       arjan@infradead.org
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005EC94C3@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EC94C3@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Feb 2006 01:50:41 +0000
Message-Id: <1138845041.5557.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-01 at 20:35 -0500, Brown, Len wrote:
> This endeavor is full of risk, and I would be extremely careful
> about enabling features that the BIOS explicitly disabled --
> unless the hardware manufacturer publicly publishes
> support for the feature, or the errata that you're working around.

Folks had code that supported AMD76x by banging the hardware directly.
On some AMD76x systems it caused corruption. Nobody AFAIK ever figured
out if it was an errata (nothing obvious in the docs/errata list) or a
bug in the code doing the banging on the chip or some other bit of
hardware on the mainboard that needed extra handling.

Alan

