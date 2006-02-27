Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWB0W4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWB0W4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWB0W4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:56:33 -0500
Received: from cantor.suse.de ([195.135.220.2]:15501 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932118AbWB0W4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:56:31 -0500
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take 3)
Date: Mon, 27 Feb 2006 23:58:17 +0100
User-Agent: KMail/1.9.1
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, benh@kernel.crashing.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
References: <44028502.4000108@soft.fujitsu.com> <200602272342.11047.ak@suse.de> <4403829C.2070706@pobox.com>
In-Reply-To: <4403829C.2070706@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602272358.18120.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 23:52, Jeff Garzik wrote:

> Its trivial to detect PCI hardware that doesn't support MMIO, the
> "IO-only" hardware Grant mentioned...

But there might be hardware that needs both PIO and MMIO
e.g. graphic cards.

How would the poor firmware distingush between those and 
MMIO only?

-Andi
