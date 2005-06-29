Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVF2Bt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVF2Bt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVF2Br7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:47:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:21408 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262268AbVF2BpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:45:17 -0400
Subject: Re: [PATCH 1/3] openfirmware: generate device table for userspace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050629003045.GD24094@locomotive.unixthugs.org>
References: <20050629003045.GD24094@locomotive.unixthugs.org>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:39:50 +1000
Message-Id: <1120009190.5133.222.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 20:30 -0400, Jeff Mahoney wrote:
>  This patch converts the usage of struct of_match to struct of_device_id,
>  similar to pci_device_id. This allows a device table to be generated, which 
>  can be parsed by depmod(8) to generate a map file for module loading.
>  
>  In order for hotplug to work with macio devices, patches to module-init-tools
>  and hotplug must be applied. Those patches are available at:
>  
> ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/

They look good. I haven't tested yet though.

Ben.

