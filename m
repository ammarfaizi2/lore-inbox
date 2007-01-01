Return-Path: <linux-kernel-owner+w=401wt.eu-S932782AbXAAT3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbXAAT3T (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbXAAT3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:29:18 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:55005 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932782AbXAAT3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:29:17 -0500
Date: Mon, 1 Jan 2007 20:21:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mitch Bradley <wmb@firmworks.com>
cc: David Miller <davem@davemloft.net>, segher@kernel.crashing.org,
       hch@infradead.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       dmk@flex.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
In-Reply-To: <45994E9F.9040904@firmworks.com>
Message-ID: <Pine.LNX.4.61.0701012019210.24520@yvahk01.tjqt.qr>
References: <20061231.024917.59652177.davem@davemloft.net>
 <20061231154103.GA7409@infradead.org> <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>
 <20070101.005714.35017753.davem@davemloft.net> <45994E9F.9040904@firmworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 1 2007 08:10, Mitch Bradley wrote:
>> 
>> We don't generally export binary representation
>> files out of /proc or /sys, in fact this rule I believe is layed
>> our precisely somewhere at least in the sysfs case.
>> 
> pci-sysfs exports PCI config space in binary.

cat /sys/bus/pci/devices/0000\:01\:00.0/subsystem_device 
0x0c60

Can't find the binary thing. But I've seen it before -- esp.
/proc/usb when it existed. It's really sad, because you can learn a
lot from the text representations. Having to figure out what the
proper utility and all its options is often takes some time.


	-`J'
-- 
