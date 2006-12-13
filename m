Return-Path: <linux-kernel-owner+w=401wt.eu-S964886AbWLMBum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWLMBum (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWLMBum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:50:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39380 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964886AbWLMBul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:50:41 -0500
Date: Tue, 12 Dec 2006 17:50:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: conke.hu@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1
Message-Id: <20061212175038.ed16c7cf.akpm@osdl.org>
In-Reply-To: <1165972662.2860.8.camel@localhost.localdomain>
References: <20061211005807.f220b81c.akpm@osdl.org>
	<1165972662.2860.8.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 09:17:42 +0800
Conke Hu <conke.hu@gmail.com> wrote:

>     Thank you for applying ATI SB600 SATA patch!
>     But it seems the patch file name should be
> "ati"-sb600-sata-quirk.patch, not "via"-sb600-sata-quirk.patch, type
> error? :)

That's the sort of thing which happens when people send me patches titled
"Re: -mm merge plans for 2.6.20".  I guess, and I don't spend a lot of time
over it, either.


>     BTW, the following line in ide/pci/atiixp.c had better be removed
> since there would be no legacy ide mode any more after this patch is
> applied.
>     "{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
> PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8a, 0xffff05, 1},"

please send a patch to fix this.
