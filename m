Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWIYLI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWIYLI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWIYLI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:08:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1001 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751135AbWIYLI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:08:26 -0400
Subject: Re: mainline aic94xx firmware woes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060925101124.GH6374@rhun.haifa.ibm.com>
References: <20060925101124.GH6374@rhun.haifa.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 12:33:04 +0100
Message-Id: <1159183984.11049.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 13:11 +0300, ysgrifennodd Muli Ben-Yehuda:
> that includes firmware support to load the firmware. Will a patch to
> optionally include the firmware inline in the kernel and thus not
> having to use an initramfs be acceptable?

We should not be including non-free firmware in the kernel, we should be
continuing to drive it out into things like initramfs.

> Also, aic94xx does not compile unless FW_LOADER is set in .config due
> to missing 'request_firmware'. What's the right thing to do here -
> aic94xx selecting it, depending on it

Either select or depend

Alan

