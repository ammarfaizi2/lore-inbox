Return-Path: <linux-kernel-owner+w=401wt.eu-S1751448AbXAOTyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbXAOTyc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbXAOTyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:54:32 -0500
Received: from [195.171.73.133] ([195.171.73.133]:34685 "EHLO
	pelagius.h-e-r-e-s-y.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbXAOTyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:54:31 -0500
Message-ID: <45ABDBF5.9000900@walrond.org>
Date: Mon, 15 Jan 2007 19:54:29 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Initramfs and /sbin/hotplug fun
References: <45AB8CB9.2000209@walrond.org> <20070115170412.GA26414@aepfle.de> <45ABBB8B.6000505@walrond.org> <20070115175437.GA26944@aepfle.de>
In-Reply-To: <20070115175437.GA26944@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> 
> Why do you need /sbin/hotplug anyway, just for firmware loading for a
> non-modular kernel?

I guess this is unusual, but FWIW...

I have a custom distro and I was just looking for the easiest way to 
create a bootable rescue pen-drive. So I just took a working distro, 
added an init->sbin/init symlink, cpio'ed it into an initramfs, and 
booted it up. Works a treat, except for the early hotplug calls.

Andrew

