Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUKJPCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUKJPCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUKJPCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 10:02:12 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:39863 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261980AbUKJO7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:59:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.10-rc1-mm4: USB storage not working on AMD64
Date: Wed, 10 Nov 2004 15:57:51 +0100
User-Agent: KMail/1.6.2
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
References: <200411101154.05304.rjw@sisk.pl> <200411100558.45934.david-b@pacbell.net>
In-Reply-To: <200411100558.45934.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411101557.51057.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 of November 2004 14:58, David Brownell wrote:
> On Wednesday 10 November 2004 02:54, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > There seems to be a problem in 2.6.10-rc1-mm4 with either USB storage (eg 
a 
> > pendrive) or hotplug on AMD64 (NForce3 chipset, ohci-hcd, SuSE 9.1).
> > Namely,  
> > if a USB pendrive is inserted into a socket, the kernel does not even 
detect 
> > it.  Here's what appears in dmesg after it's inserted:
> > 
> > ohci_hcd 0000:00:02.0: wakeup
> > 
> > Other USB devices (eg a mouse) seem to work normally.
> 
> I recently posted several USB PM fixes that make things work better
> in my testing, and it sounds like they'd probably help here too.

Are they available as stand-alone patches?  I'd like to test ...

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
