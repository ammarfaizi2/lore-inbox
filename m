Return-Path: <linux-kernel-owner+w=401wt.eu-S1751276AbXAUHUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXAUHUZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 02:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbXAUHUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 02:20:25 -0500
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:1273 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXAUHUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 02:20:24 -0500
Message-ID: <45B31433.5000408@xs4all.nl>
Date: Sun, 21 Jan 2007 08:20:19 +0100
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>
Subject: Re: USB extension (repeater) cable
References: <45B0E672.4080404@xs4all.nl> <20070120000158.GD12615@kroah.com> <45B313AD.7080705@zytor.com>
In-Reply-To: <45B313AD.7080705@zytor.com>
X-Enigmail-Version: 0.94.2.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Greg KH wrote:
>> On Fri, Jan 19, 2007 at 04:40:34PM +0100, Udo van den Heuvel wrote:
>>>
>>> I just tried my shiny new usb extension cable (repeater):
>>>
>>> Jan 19 16:01:17 epia kernel: usb 5-1: new high speed USB device using
>>> ehci_hcd and address 60
>>> Jan 19 16:01:17 epia kernel: usb 5-1: configuration #1 chosen from 1
>>> choice
>>> Jan 19 16:01:17 epia kernel: hub 5-1:1.0: USB hub found
>>> Jan 19 16:01:17 epia kernel: hub 5-1:1.0: 4 ports detected
>>> Jan 19 16:01:18 epia kernel: hub 5-1:1.0: Cannot enable port 1.  Maybe
>>> the USB cable is bad?
>>> Jan 19 16:01:22 epia last message repeated 3 times
>>> Jan 19 16:01:23 epia kernel: hub 5-1:1.0: Cannot enable port 2.  Maybe
>>> the USB cable is bad?
>>> Jan 19 16:01:26 epia last message repeated 3 times
>>> Jan 19 16:01:27 epia kernel: hub 5-1:1.0: Cannot enable port 3.  Maybe
>>> the USB cable is bad?
>>> Jan 19 16:01:31 epia last message repeated 3 times

[...]

> Actually, what it looks like is even simpler.  The extension cable
> contains a four-port hub chip (which is the most common commodity chip)
> and haven't bothered changing the descriptor to tell the computer only
> one port is actually active.  So only one port can be activated, and the
> others are stubbed out in some evil way.  In that case, it should be
> noisy but harmless.

I will do some more testing then.
Is there a way to get rid of the messages?
