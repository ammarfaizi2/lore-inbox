Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUD2UHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUD2UHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbUD2UHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:07:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:65499 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264954AbUD2UFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:05:49 -0400
Date: Thu, 29 Apr 2004 13:01:27 -0700
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6-bk] pci.ids update from sf.net + add IXP4xx to pci_ids.h
Message-ID: <20040429200127.GA20268@kroah.com>
References: <20040415175639.GA15379@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415175639.GA15379@plexity.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've applied this patch now, but I get the following warnings when
building:

  DEVLIST drivers/pci/devlist.h
  Line 2335: Device name too long. Name truncated.
  Adaptec AAR-1210SA SATA HostRAID Controller
  Line 2353: Device name too long. Name truncated.
  Silicon Image SiI 3114 SATARaid Controller
  Line 5158: Device name too long. Name truncated.
  IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be IT8212, embedded seems to be ITE8212)
  Line 6101: Device name too long. Name truncated.
  Cisco Aironet 340 802.11b Wireless LAN Adapter/Aironet PC4800
  Line 6824: Device name too long. Name truncated.
  SMC2602W EZConnect / Addtron AWA-100 / Eumitcom PCI WL11000

Care to send me a patch to fix these up?

thanks,

greg k-h
