Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWBWPD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWBWPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWBWPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:03:27 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25311 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751389AbWBWPD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:03:27 -0500
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FD347B.6030802@comcast.net>
References: <1140445182.26526.1.camel@localhost.localdomain>
	 <43FD347B.6030802@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 15:07:45 +0000
Message-Id: <1140707265.4332.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-22 at 23:05 -0500, Ed Sweetman wrote:
> With this patch set and the attached config.  Nvidia Nforce4 chipset 
> from asus A8N-E with pata and sata enabled (no ide drivers) I get the 
> following error i copied by hand (half assed) during bootup.
> 
> Process Swapper  "lots of addresses"

Thanks for all the reports on the oops on boot. I was able to duplicate
it and fix the dumb bug that caused it.

New patch (2.6.16-rc4-ide2)

	http://zeniv.linux.org.uk/~alan/IDE
