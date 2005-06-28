Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVF1AFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVF1AFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVF1AFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:05:46 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3367 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262117AbVF1AFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:05:38 -0400
Date: Mon, 27 Jun 2005 18:03:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: USB ohci vs ehci
In-reply-to: <4k9XR-2VC-35@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42C093C1.9090008@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4k9XR-2VC-37@gated-at.bofh.it> <4k9XR-2VC-35@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Ramsay wrote:
> I have an NEC-based 'UP215-N101' USB 2.0 PCI card which can apparently
> appear as a device under ohci-hcd or ehci-hcd, depending on which one
> is loaded.  If both modules are loaded, the device doesn't seem to
> work, as it is detected by both

USB 2.0 controllers are supposed to be detected by both EHCI and either 
OHCI or UHCI, since they support both interfaces. EHCI is only used for 
USB 2.0 high-speed devices and OHCI or UHCI is used for other devices.

If the controller's not working, the problem will be something else..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

