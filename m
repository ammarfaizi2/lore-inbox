Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVCBXe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVCBXe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCBXe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:34:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:22480 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261384AbVCBXdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:33:06 -0500
Subject: Re: [PATCH 1/3] openfirmware: generate device table for userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeffrey Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050301211814.GB16465@locomotive.unixthugs.org>
References: <20050301211814.GB16465@locomotive.unixthugs.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 10:30:28 +1100
Message-Id: <1109806228.5610.118.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 16:18 -0500, Jeffrey Mahoney wrote:
> This patch converts the usage of struct of_match to struct of_device_id,
> similar to pci_device_id. This allows a device table to be generated, which 
> can be parsed by depmod(8) to generate a map file for module loading.
> 
> In order for hotplug to work with macio devices, patches to module-init-tools
> and hotplug must be applied. Those patches are available at:
> 
> ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

Look good, Andrew, please merge.

Ben.


