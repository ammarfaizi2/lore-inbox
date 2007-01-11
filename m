Return-Path: <linux-kernel-owner+w=401wt.eu-S1750944AbXAKR1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbXAKR1m (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbXAKR1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:27:42 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:56359 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbXAKR1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:27:41 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: 2.6.20-rc4: usb somehow broken
Date: Thu, 11 Jan 2007 18:28:01 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200701111820.46121.prakash@punnoor.de>
In-Reply-To: <200701111820.46121.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701111828.02119.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 11. Januar 2007 18:20 schrieb Prakash Punnoor:
> Hi,
> 
> I can't scan anymore. :-( I don't know which rc kernel introduced it, but this 
> are the messages I get (w/o touching the device/usb cable except pluggin it 
> in for the first time):
> 
> usb 1-1.2: new full speed USB device using ehci_hcd and address 4
> ehci_hcd 0000:00:0b.1: qh ffff81007bc6c280 (#00) state 4
> usb 1-1.2: configuration #1 chosen from 1 choice
> usb 1-1.2: USB disconnect, address 4
> usb 1-1.2: new full speed USB device using ehci_hcd and address 5
> usb 1-1.2: configuration #1 chosen from 1 choice
> usb 1-1.2: USB disconnect, address 5
> usb 1-1.2: new full speed USB device using ehci_hcd and address 6
> usb 1-1.2: configuration #1 chosen from 1 choice
> usb 1-1.2: USB disconnect, address 6
> usb 1-1.2: new full speed USB device using ehci_hcd and address 7
> usb 1-1.2: configuration #1 chosen from 1 choice
> usb 1-1.2: USB disconnect, address 7
> usb 1-1.2: new full speed USB device using ehci_hcd and address 8
> usb 1-1.2: configuration #1 chosen from 1 choice
> 
> 
> Shouldn't the ohci module handle the scanner? The scanner is connected through 
> a hub.

Therefore it goes to EHCI. Can you try a direct connection?

> I don't remember how 2.6.19 handled it, or whether I used some new exotic 
> setting which causes the breakage.

Could you try 2.6.19?

> Well, I'll test this week-end and upload more infos then. If you already have 
> some ideas in the meantime, let me know.

Please test with CONFIG_USB_DEBUG

	Regards
		Oliver
