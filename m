Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVDDQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVDDQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVDDQ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:56:59 -0400
Received: from webapps.arcom.com ([194.200.159.168]:30730 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261283AbVDDQwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:52:30 -0400
Message-ID: <425170CD.5050200@cantab.net>
Date: Mon, 04 Apr 2005 17:52:29 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050329)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: iomapping a big endian area
References: <1112475134.5786.29.camel@mulgrave>  <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>  <20050402183805.20a0cf49.davem@davemloft.net>  <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>  <1112499639.5786.34.camel@mulgrave>  <20050402200858.37347bec.davem@davemloft.net>  <1112502477.5786.38.camel@mulgrave>  <1112601039.26086.49.camel@gaston> <1112623143.5813.5.camel@mulgrave> <42516034.7000802@arcom.com> <Pine.LNX.4.61.0504041155530.4934@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0504041155530.4934@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2005 16:59:19.0609 (UTC) FILETIME=[A484FA90:01C53937]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> But the Linux interface (on the CPU side of the PCI bus interface)
> doesn't care about the implimentation details in the XScale
> Core. That's why it's a complete subsystem, isolated from the
> ix86 by the PCI/Bus interface.

Hmmm.

*takes a long hard look at the IXP425 based board in front of him*

You're right.  It's really is a PCI add-on card for an x86 platform.
All this time I've been thinking it was a standalone processor board.
Thanks for clearing that up!

David Vrabel

ps. The IXP425 is an ARM (Intel's XScale architecture) based processor.
