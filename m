Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161279AbWASIq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbWASIq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbWASIq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:46:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11401
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161279AbWASIqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:46:55 -0500
Date: Thu, 19 Jan 2006 00:39:30 -0800 (PST)
Message-Id: <20060119.003930.117351070.davem@davemloft.net>
To: ebiederm@xmission.com
Cc: bos@pathscale.com, akpm@osdl.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, greg@kroah.com, openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	<m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 19 Jan 2006 01:25:39 -0700

> mmap(/dev/mem)
> There is also an interface in /proc or /sys I forget which
> that let's you select the individual bar for a pci device.
> You don't need to do anything, in your driver to support this.

Yes, please use /proc/bus/pci/* device file mmap()s or even
better the PCI ones under /sys work too.

I think libpci even has some help for this.
