Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbUKJOIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbUKJOIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUKJOEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:04:54 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:34460 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261923AbUKJOCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:02:01 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.10-rc1-mm4: USB storage not working on AMD64
Date: Wed, 10 Nov 2004 05:58:45 -0800
User-Agent: KMail/1.7.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200411101154.05304.rjw@sisk.pl>
In-Reply-To: <200411101154.05304.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411100558.45934.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 November 2004 02:54, Rafael J. Wysocki wrote:
> Hi,
> 
> There seems to be a problem in 2.6.10-rc1-mm4 with either USB storage (eg a 
> pendrive) or hotplug on AMD64 (NForce3 chipset, ohci-hcd, SuSE 9.1).
> Namely,  
> if a USB pendrive is inserted into a socket, the kernel does not even detect 
> it.  Here's what appears in dmesg after it's inserted:
> 
> ohci_hcd 0000:00:02.0: wakeup
> 
> Other USB devices (eg a mouse) seem to work normally.

I recently posted several USB PM fixes that make things work better
in my testing, and it sounds like they'd probably help here too.

- Dave

 
> Of course such problems do not occur on 2.6.10-rc1.  On 2.6.10-rc1-mm3 I've 
> had this problem only on a dual-Opteron box, but on 2.6.10-rc1-mm4 I see it 
> on a one-processor box either.

