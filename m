Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVIZPUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVIZPUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVIZPUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:20:01 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:56466 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S932265AbVIZPUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:20:00 -0400
Date: Mon, 26 Sep 2005 08:25:49 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Raj, Ashok" <ashok.raj@intel.com>, bjorn.helgaas@hp.com,
       Arjan van de Ven <arjan@redhat.com>
Subject: RE: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D5D@USRV-EXCH4.na.uis.unisys.com>
Message-ID: <Pine.LNX.4.61.0509260754290.1684@montezuma.fsmlabs.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D5D@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Protasevich, Natalie wrote:

> Great news, thanks! I will start testing it, pretty sure I can arrange
> MSI devices, too.
> As for your comment about vector allocation policy - allocation on the
> node where device resides does sound logical to me...

Thanks for checking it out Natalie, i think the concern there would be 
nodes registered as such to Linux with no processors online at initial 
insertion but having devices on the node busses.

Thanks,
	Zwane

