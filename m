Return-Path: <linux-kernel-owner+w=401wt.eu-S1751053AbXAOQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXAOQov (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXAOQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:44:51 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:53852 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbXAOQot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:44:49 -0500
Date: Mon, 15 Jan 2007 17:44:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Walrond <andrew@walrond.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Initramfs and /sbin/hotplug fun
In-Reply-To: <45AB8CB9.2000209@walrond.org>
Message-ID: <Pine.LNX.4.61.0701151744220.23841@yvahk01.tjqt.qr>
References: <45AB8CB9.2000209@walrond.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 15 2007 14:16, Andrew Walrond wrote:
>
> If the initramfs root filesystem contains /sbin/hotplug, the kernel 
> starts calling it very early in the kernel boot process, well before 
> /init has been called. In my case this resulted in lots of hotplug 
> segfault messages as the kernel boots, followed by a thoroughly 
> unhappy hotplug+udev once /init actually gets control.

Could this be a case of http://lkml.org/lkml/2006/12/3/19 ?

	-`J'
-- 
