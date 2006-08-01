Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWHAFSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWHAFSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWHAFSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:18:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62863 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161053AbWHAFSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:18:44 -0400
Date: Mon, 31 Jul 2006 22:18:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2/3] add-force-of-use-mmconfig.patch
Message-Id: <20060731221841.9195556c.akpm@osdl.org>
In-Reply-To: <44CDBF1E.2010001@ed-soft.at>
References: <44CDBF1E.2010001@ed-soft.at>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 10:28:14 +0200
Edgar Hucek <hostmaster@ed-soft.at> wrote:

> This Patch add force for mmconfig. On Intel Macs the efi firmaware gives
> a different memory map then ACPI_MCFG provides. This makes the check wether
> to use mmconfig or not fail.

Sorry, you cannot do this.  I already merged this patch into -mm, and
followed that up with two bugfix patches, both of which you were copied on.

Now you're sending out the original patch, without the bugfixes which
Adrian and I prepared.

If you think these patches should be merged into 2.6.18 at this late a
stage, please give reasons and if they're agreeable I can send it all to
Linus.  But sending out known-buggy stuff which has already been fixed
doesn't help anyone.

Also, please don't use filenames as patch descriptions.  See section 2 of
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.

Thanks.
