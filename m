Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269592AbUINXSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269592AbUINXSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUINXP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:15:58 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:11976 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267921AbUINXPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:15:09 -0400
Date: Tue, 14 Sep 2004 16:11:42 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org
cc: hannal@us.ibm.com, greg@kroah.com, wli@holomorphy.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_sio.c] [2/2] convert pci_find_device to pci_get_device
Message-ID: <18720000.1095203502@w-hlinder.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0409141539200.22202-100000@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.33.0409141539200.22202-100000@osdlab.pdx.osdl.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, September 14, 2004 03:56:54 PM -0700 Judith Lebzelter <judith@osdl.org> wrote:

> The alpha filter does a 'defconfig' build, and it had 2 warnings, 0
> errors.
> 
> Unfortunately, the 2.6.9-rc1 has a few errors for the 'defconfig' build,
> which is why I did not apply it there.
> 
> Judith Lebzelter
> OSDL


Thanks Judith,

That is awesome. I see the warnings were for different .c files than the ones my patches touched.
Warning List:

drivers/serial/8250_pnp.c:421: warning: cast to pointer from integer of different size
drivers/serial/8250_pnp.c:428: warning: cast from pointer to integer of different size

RESULT: PASS
RESULT-DETAIL: 2 warnings, 0 errors

So it appears all is good with my patches. Thanks a lot!

Hanna




