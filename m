Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVJARq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVJARq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 13:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVJARq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 13:46:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:46787 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750723AbVJARq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 13:46:56 -0400
Date: Sat, 1 Oct 2005 10:46:09 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Patterson <andrew.patterson@hp.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Message-ID: <20051001174609.GA13084@kroah.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com> <1128105594.10079.109.camel@bluto.andrew> <433D9035.6000504@adaptec.com> <1128111290.10079.147.camel@bluto.andrew> <20050930202234.GA2571@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930202234.GA2571@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 02:22:34PM -0600, Matthew Wilcox wrote:
> There's precedent for binary data in sysfs -- pci config space is one.

binary data in sysfs is for stuff that is just a "pass through" for the
kernel.  Copying the pci config space, in raw form from the device to
userspace is one such example.  Firmware blobs is another one.

Binary data in sysfs is _not_ for exporting kernel structures or other
data that the kernel "understands" and manipulates.

Hope this helps,

greg k-h
