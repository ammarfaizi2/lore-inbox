Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWJWUAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWJWUAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWJWUAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:00:24 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:37037 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S965022AbWJWUAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:00:22 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: David Hollis <dhollis@davehollis.com>
Subject: Re: 2.6.19-rc2-mm2: D-Link DUB-E100 Rev. B broken
Date: Mon, 23 Oct 2006 21:59:39 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200610232041.48998.bero@arklinux.org> <1161630300.4824.7.camel@dhollis-lnx.sunera.com> <200610232145.23819.bero@arklinux.org>
In-Reply-To: <200610232145.23819.bero@arklinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232159.40022.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23. October 2006 21:45, Bernhard Rosenkraenzer wrote:
> Looks like the USB port is acting up (only with the new kernel -- so this
> is probably triggered by a USB driver or possibly APIC change [will try
> with pci=noapic next])

pci=noapic doesn't change anything, but I remember having weird IRQ problems 
on identical boxes before (in particular, a normal 8139too network card 
doesn't work if ACPI 2.0 support is disabled in the BIOS), so this is a 
likely candidate for "severely broken BIOS needs workarounds and happened to 
work earlier by coincidence"
