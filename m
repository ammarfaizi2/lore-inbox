Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVIZXpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVIZXpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVIZXpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:45:55 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:22260 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964776AbVIZXpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:45:54 -0400
Date: Mon, 26 Sep 2005 17:49:21 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: USB on nForce4 board only working with pci=routeirq
In-reply-to: <4R0rb-4nk-13@gated-at.bofh.it>
To: Florian Engelhardt <flo@dotbox.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43388901.8090500@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <4R0rb-4nk-13@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Engelhardt wrote:
> Hello,
> 
> i own a nForce4 mainboard from elitegroup. It has USB 1.1 and 2.0.
> If i start the computer normal with my 2.6.13 kernel i get the following:
> Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: OHCI Host Controller
> Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: USB HC takeover failed! 
> (BIOS/SMM bug)
> Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: can't reset
> Sep 25 10:12:54 discovery ACPI: PCI interrupt for device 0000:00:02.0 disabled
> Sep 25 10:12:54 discovery ohci_hcd 0000:00:02.0: init 0000:00:02.0 fail, -16
> Sep 25 10:12:54 discovery ohci_hcd: probe of 0000:00:02.0 failed with error -16
> 
> And non of my USB-devices is wokring anymore.
> I than switched to 2.6.14-rc2-mm1, but the same behavior.
> I tried to parse pci=routeirq to the kernel, and than it was wokring again.
> 
> It worked perfect, also without pci=routeirq until 25th of september.
> I updated the bios, but that was one month ago, and is was using my usb
> devices since then with no problems, so i don´t know, what couses this
> problem now.

We probably need full dmesg output. Also, are you currently using the 
latest BIOS available?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

