Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWHXVzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWHXVzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWHXVzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:55:21 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:20564 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id S1030487AbWHXVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:55:20 -0400
Date: Fri, 25 Aug 2006 07:58:52 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Luca Corti <luca@leenoox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Motorola v360 external USB storage
In-Reply-To: <1156421819.7974.5.camel@cdevo.cdlan.it>
Message-ID: <Pine.LNX.4.05.10608250753020.17309-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006, Luca Corti wrote:

> I've got a Motorola v360 phone I can connect via USB to access its
> Transflash storage. This works flawlessly under Windows, while under
> linux 2.6.17 I can not mount it.

I've also got a v360, and this "works for me" on Linux (admittedly with
older kernels, including 2.4 (Debian Sarge)).

[...]
> Aug 24 13:11:32 cdevo kernel: [17182088.396000] sd 0:0:0:0: Attached
> scsi generic sg0 type 0
> Aug 24 13:11:33 cdevo kernel: [17182089.380000] sd 0:0:0:0: SCSI error:
> return code = 0x8000002
> Aug 24 13:11:33 cdevo kernel: [17182089.380000] sda: Current: sense key:
> Medium Error
> Aug 24 13:11:33 cdevo kernel: [17182089.380000]     Additional sense: No
> additional sense information
> Aug 24 13:11:33 cdevo kernel: [17182089.380000] end_request: I/O error,
> dev sda, sector 245953
> Aug 24 13:11:33 cdevo kernel: [17182089.380000] Buffer I/O error on
> device sda1, logical block 245856
> Aug 24 13:11:33 cdevo kernel: [17182089.528000] sd 0:0:0:0: SCSI error:
> return code = 0x8000002
> Aug 24 13:11:33 cdevo kernel: [17182089.528000] sda: Current: sense key:
> Medium Error
> Aug 24 13:11:33 cdevo kernel: [17182089.528000]     Additional sense: No
> additional sense information
> Aug 24 13:11:33 cdevo kernel: [17182089.528000] end_request: I/O error,
> dev sda, sector 245954
[snip]

You sure the flash is not broken?  Any chance of trying a different flash
in this phone or trying this flash in another device?

HTH,
Neale.

