Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWIYOHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWIYOHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWIYOHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:07:34 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:12440 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751562AbWIYOHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:07:33 -0400
Date: Mon, 25 Sep 2006 17:07:30 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mainline aic94xx firmware woes
Message-ID: <20060925140730.GO6374@rhun.haifa.ibm.com>
References: <20060925101124.GH6374@rhun.haifa.ibm.com> <20060925113042.GA18946@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925113042.GA18946@aepfle.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 01:30:42PM +0200, Olaf Hering wrote:
> On Mon, Sep 25, Muli Ben-Yehuda wrote:
> 
> > The recently merged aic94xx in mainline requires external firmware
> > support. This, in turn, necessitates an initrd/initramfs environment
> > that includes firmware support to load the firmware. Will a patch to
> > optionally include the firmware inline in the kernel and thus not
> > having to use an initramfs be acceptable?
> 
> initramfs is always in use. Wether you pass in an additional image via
> the bootloader is up to you.
> Adding the firmware and required tools to your vmlinux binary is trivial
> with CONFIG_INITRAMFS_SOURCE="/some/file"

Thanks, I'll look into this.

Cheers,
Muli
