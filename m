Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUIMUaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUIMUaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268929AbUIMUaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:30:25 -0400
Received: from main.gmane.org ([80.91.229.2]:52186 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268894AbUIMUaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:30:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.9-rc1-mm5
Date: Mon, 13 Sep 2004 20:30:02 +0000 (UTC)
Message-ID: <slrnckc0qa.qoe.psavo@varg.dyndns.org>
References: <20040913015003.5406abae.akpm@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm5/

Some badness with OHCI usb, usb devices just 'aren't there' for me.

- good -
Sep  9 18:51:58 tienel kernel: ohci_hcd 0000:02:00.0: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
Sep  9 18:51:58 tienel kernel: ohci_hcd 0000:02:00.0: irq 19, pci mem 0xf4000000
Sep  9 18:51:58 tienel kernel: ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
Sep  9 18:51:58 tienel kernel: hub 1-0:1.0: USB hub found
Sep  9 18:51:58 tienel kernel: hub 1-0:1.0: 4 ports detected
Sep  9 18:51:58 tienel kernel: USB Universal Host Controller Interface driver v2.2
Sep  9 18:51:58 tienel kernel: usb 1-1: new full speed USB device using address 2
- -

- bad (as in 2.6.9-rc1-mm5) -
Sep 13 23:01:19 tienel kernel: ohci_hcd 0000:02:00.0: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
Sep 13 23:01:19 tienel kernel: ohci_hcd 0000:02:00.0: irq 19, pci mem 0xf4000000
Sep 13 23:01:19 tienel kernel: ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
Sep 13 23:01:19 tienel kernel: ohci_hcd 0000:02:00.0: remove, state 0
Sep 13 23:01:19 tienel kernel: ohci_hcd 0000:02:00.0: USB bus 1 deregistered
Sep 13 23:01:19 tienel kernel: ohci_hcd: probe of 0000:02:00.0 failed with error -16
- -

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

