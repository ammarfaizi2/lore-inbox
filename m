Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbULEREJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbULEREJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbULEQ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 11:59:34 -0500
Received: from a.mail.sonic.net ([64.142.16.245]:23242 "EHLO a.mail.sonic.net")
	by vger.kernel.org with ESMTP id S261320AbULEQ7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 11:59:16 -0500
Date: Sun, 5 Dec 2004 08:59:08 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.28 config prompts for EXPERIMENTAL features when shouldn't
Message-ID: <20041205165908.GA25139@thune.sonic.net>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a basic kernel config that I use for boot disks that has
CONFIG_EXPERIMENTAL set to no.  Yet, with using my old 2.4.26 config with
2.4.28, I'm getting prompted for new experimental features:

  NVIDIA SATA support (EXPERIMENTAL) (CONFIG_SCSI_SATA_NV) [N/y/m/?] (NEW) 
  Ethernet Gadget (EXPERIMENTAL) (CONFIG_USB_ETH) [M/n/?] 
    RNDIS support (EXPERIMENTAL) (CONFIG_USB_ETH_RNDIS) [N/y/?] (NEW) 

The fact that CONFIG_USB_ETH was set in my 2.4.26 config seems to indicate
this is not a new problem.  :->

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
