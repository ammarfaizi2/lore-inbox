Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbTIRNb2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTIRNb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:31:28 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:24998 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S261313AbTIRNb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:31:27 -0400
Date: Thu, 18 Sep 2003 14:31:25 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-ac3
In-Reply-To: <200309152306.h8FN6lF04552@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0309181430110.8770@r2-pc.dcs.qmul.ac.uk>
References: <200309152306.h8FN6lF04552@devserv.devel.redhat.com>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (19zysX-0006Eh-Jv)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15 Alan Cox wrote:

>This one should be treated gently initially.
>
>Linux 2.4.22-ac3

[built with everything modular except romfs and ELF]

depmod: *** Unresolved symbols in /lib/modules/2.4.22-ac3/kernel/drivers/ide/ide-core.o
depmod:         ide_wait_hwif_ready
depmod:         ide_probe_for_drive
depmod:         ide_probe_reset
depmod:         ide_tune_drives
make: *** [_modinst_post] Error 1

Is this helpful?

Matt
